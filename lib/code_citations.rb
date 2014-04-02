require "code_citations/sources/cran"
require "code_citations/sources/europe_pmc"
require "code_citations/sources/plos"

module CodeCitations

  def self.for(software)
    found = []
    metadata = metadata(software, :CRAN)
    if metadata
      found += CodeCitations::EuropePmc.search(
        metadata["Name"],
        metadata["URLs"],
        metadata["Author"]
      )
      found += CodeCitations::Plos.search(
        metadata["Name"],
        metadata["URLs"],
        metadata["Author"]
      )
    else
      raise "Software not found"
    end
    found.uniq
  end

  private

  def self.metadata(software, source = :CRAN)
    if source == :CRAN
      Cran.metadata(software)
    end
  end

end
