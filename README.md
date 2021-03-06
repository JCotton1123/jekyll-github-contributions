# Jekyll Github Contributions Plugin

Jekyll generator plugin that generates a Github contributions data file.

Why do this via a generator instead of with Javascript?

B/c Github API rate limits anonymous API requests pretty aggressively.

## Install

* Add `jekyll-github-contributions` to your Jekyll Gemfile
* Add `jekyll-github-contributions` to the gems list within Jekyll's `_config.yml`

## Config

Add the following to `_config.yml` and adjust as desired:

```
githubcontributions:
  username: JCotton1123 # Github username
  page_limit: 3 # Number of pages of data to grab from Github
  cache: 300 # Number of seconds to cache the data file
```

## Usage

Within a page, post, or layout:

```erb
<div id="contributions" class="contributions">
  <h3>Some recent open source contributions I've made:</h3>
  <ul>
  {% for contribution in site.data.github-contributions limit:10 %}
    <li>
      <a href="{{ contribution.html_url }}">{{ contribution.title }}</a>
    </li>
  {% endfor %}
  </ul> 
</div>
```
