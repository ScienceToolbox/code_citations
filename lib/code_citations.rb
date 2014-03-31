require "code_citations/version"
require "code_citations/sources/cran"
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
