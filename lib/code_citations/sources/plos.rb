require 'nokogiri'
require 'open-uri'
require 'json'

module CodeCitations
  module Plos
    def self.search(name, urls, authors)
      page = 1
      found = []

      authors = "(" +
        authors[0..2].map{|author| "(" + author.split(' ').join(' OR ') + ")"}.join(' OR ') +
      ")"

      search_string = "(everything:\"#{name}\") OR "
      search_string += "(reference:" + [name, authors].map{|s| "\"#{s}\""}.join(' AND ') + ")"

      urls.each do |url|
        search_string += " OR everything:\"#{url}\""
      end

      loop do
        start = (page - 1) * 100
        api_url = "http://api.plos.org/search?q=#{search_string}&api_key=7Jne3TIPu6DqFCK=&rows=100&wt=json&start=#{start}"
        response = open(URI.encode(api_url)).read
        results = JSON.parse(response)['response']['docs']
        break if results.empty?
        results.each do |result|
          doi = result['id']
          next unless doi
          found << doi
        end
        page += 1
      end
      found.uniq
    end
  end
end