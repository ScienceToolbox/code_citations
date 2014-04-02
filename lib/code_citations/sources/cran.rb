require 'nokogiri'
require 'open-uri'

module CodeCitations
  module Cran
    def self.metadata(package)
      html = open("http://cran.r-project.org/package=#{package}").read
      html = Nokogiri::HTML(html)
      metadata = {}
      metadata['Name'] = html.css('h2').first.text.gsub("\n", ' ')
      metadata['Description'] = html.css('p').first.text.gsub("\n", ' ')
      metadata['URLs'] = ["http://cran.r-project.org/package=#{package}",
        "http://cran.r-project.org/web/packages/#{package}"]
      html.css('tr').each do |row|
        key = row.css('td')[0].text.strip.gsub(/:$/, '')
        value = row.css('td')[1].text.strip.gsub("\n", ' ')
        if key == 'Author'
          value.gsub!(/\[.*?\]/, '')
          metadata[key] = value.split(', ')
        else
          metadata[key] = value
        end
      end
      metadata
    end
  end
end