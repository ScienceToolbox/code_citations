require 'nokogiri'
require 'open-uri'

module CodeCitations
  module Cran
    def self.metadata(package)
      html = open("http://cran.r-project.org/package=#{package}").read
      html = Nokogiri::HTML(html)
      metadata = {}
      metadata['Name'] = html.css('h2').first.text
      metadata['Description'] = html.css('p').first.text
      html.css('tr').each do |row|
        key = row.css('td')[0].text.strip.gsub(/:$/, '')
        metadata[key] = row.css('td')[1].text.strip
      end
      metadata
    end
  end
end