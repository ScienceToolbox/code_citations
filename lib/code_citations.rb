require "code_citations/version"
require "code_citations/sources/cran"
require "code_citations/sources/europe_pmc"
require "code_citations/sources/plos"

module CodeCitations

  def self.for(software)

  end

  private

  def self.metadata(software, source = :CRAN)
    if source == :CRAN
      Cran.metadata(software)
    end
  end

end
