require 'nokogiri'
require 'open-uri'
require 'json'

module CodeCitations
  module EuropePmc
    def self.search(name, urls, authors)
      page = 1
      found = []

      authors = "(" +
        authors[0..2].map do |author|
          author.
            split(' ').
            map{|a| "(REF:\"#{a}\")"}.
            join(' OR ')
        end.join(' OR ') +
      ") AND "

      query = "(REF:\"#{name}\") AND "
      query += authors

      # Peculiarity, searching for text with '=' broken on API-side
      urls.map!{|url| url.gsub('=', '*')}

      query += "(" + urls.map{|u| "(BODY:\"#{}\")"}.join(' OR ') + ")"

      loop do
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1907.0 Safari/537.36"

        api_url = "http://www.ebi.ac.uk/europepmc/webservices/rest/search/query=#{URI.encode(query)}&dataset=fulltext&page=#{page}&resultType=core&format=json"

        response = open(api_url, 'User-Agent' => user_agent).read
        results = JSON.parse(response)['resultList']['result']
        break if results.empty?
        results.each do |result|
          doi = result['doi']
          next unless doi
          found << doi
        end
        page += 1
      end
      found.uniq
    end
  end
end