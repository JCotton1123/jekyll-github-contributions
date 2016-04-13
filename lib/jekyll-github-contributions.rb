require 'jekyll'
require 'net/http'
require 'json'

module Jekyll
  # Generates a github contributions data file
  class GithubContributionsGenerator < Jekyll::Generator
    DATA_FILE = '_data/github-contributions.json'.freeze
    CONTRIBUTIONS_API_URL = 'https://api.github.com/search/issues?q=type:pr+is:merged+author:%s&per_page=100'.freeze

    def generate(site)
      settings = site.config['githubcontributions']

      return if File.exist?(DATA_FILE) && (File.mtime(DATA_FILE) + settings['cache']) > Time.now

      contributions = []

      contributions_url = format(CONTRIBUTIONS_API_URL, settings['username'])

      Jekyll.logger.info 'Generating Github contributions data file'
      page = 1
      loop do
        response = Net::HTTP.get_response(URI(contributions_url + '&page=' + page.to_s))

        if response.code != '200'
          Jekyll.logger.warn "Cound not retrieve Github contribution data: #{response.body}"
          return
        end

        results = JSON.parse(response.body)
        contributions.concat(results['items'])

        break if contributions.length >= results['total_count']
        page += 1
      end

      Dir.mkdir('_data') unless Dir.exist?('_data')
      File.write(DATA_FILE, contributions.to_json)
    end
  end
end
