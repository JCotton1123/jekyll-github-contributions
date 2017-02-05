require 'jekyll'
require 'net/http'
require 'json'

module Jekyll
  # Generates a github contributions data file
  class GithubContributionsGenerator < Jekyll::Generator
    DATA_FILE = '_data/github-contributions.json'.freeze
    GITHUB_API_HOST = 'api.github.com'.freeze
    CONTRIBUTIONS_URL = '/search/issues?q=type:pr+is:merged+author:%s&per_page=100&page=%i'.freeze

    def generate(site)
      settings = {
        'cache' => 300,
        'page_limit' => 10
      }.merge(site.config['githubcontributions'])

      return if File.exist?(DATA_FILE) && (File.mtime(DATA_FILE) + settings['cache']) > Time.now
      Jekyll.logger.info 'Generating Github contributions data file'

      contributions = []

      client = Net::HTTP.new(GITHUB_API_HOST, 443)
      client.use_ssl = true

      page = 1
      loop do
        url = format(CONTRIBUTIONS_URL, settings['username'], page)
        response = client.get(url, 'Accept' => 'application/json')
        if response.code != '200'
          Jekyll.logger.warn "Cound not retrieve Github data: #{response.body}"
          return
        end

        results = JSON.parse(response.body)
        contributions.concat(results['items'])

        break if page >= settings['page_limit'].to_i
        break if contributions.length >= results['total_count']
        page += 1
      end

      Dir.mkdir('_data') unless Dir.exist?('_data')
      File.write(DATA_FILE, contributions.to_json)
    end
  end
end
