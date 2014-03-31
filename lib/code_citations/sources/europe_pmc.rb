require 'nokogiri'
require 'open-uri'
require 'json'

module CodeCitations
  module EuropePmc
    def self.search(name, urls, author)
      page = 1
      found = []
      while !defined?(results) || !results.empty?
        puts "Processing page #{page} of EuropePMC API results."
        puts "Found DOIs: #{found}"
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1907.0 Safari/537.36"
        api_url = "http://www.ebi.ac.uk/europepmc/webservices/rest/search/query=#{URI.encode(name)}&dataset=fulltext&page=#{page}&resultType=core&format=json"

        response = open(api_url, 'User-Agent' => user_agent).read

        results = JSON.parse(response)['resultList']['result']

        results.each do |result|
          doi = result['doi']
          next unless doi
          paper_url = doi = 'http://dx.doi.org/' + doi
          # If URL is in abstract, it's a citation
          urls.each do |url|
            if result['abstractText'] =~ /#{Regexp.escape(url)}/i
              found << doi
              next
            end
          end
          # If name and author are in the same paragraph, it's a citation?
          begin
            possible_match = result['fullTextUrlList']['fullTextUrl'].
              select{|u| u['availability'] == 'Free' && u['documentStyle'] == 'html' ||
                u['availability'] == 'Open access' && u['documentStyle'] == 'html'
              }

            url = possible_match.empty? ? paper_url : possible_match.first['url']
            paper = Nokogiri::HTML(open(url, 'User-Agent' => user_agent).read)

            urls.each do |url|
              if paper.text =~ /#{Regexp.escape(url)}/i
                found << doi
                next
              end
            end
            paper.xpath("//p[contains(text(), \"#{name}\")] | //li[contains(text(), \"#{name}\")]").each do |p|
              author.split(' ').each do
                if p.index author
                  found << doi
                  break
                end
              end
            end
          rescue StandardError => e
            puts "Failed. #{e.message}"
          end
        end
        page += 1
      end
      found.uniq
    end
  end
end