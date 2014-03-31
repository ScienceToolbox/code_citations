require 'test/unit'
require 'code_citations'
require 'test_helper'
require 'rinruby'
require 'open-uri'
require 'pry'

class CodeCitationsTest < Test::Unit::TestCase
  def test_r_integration
    R.eval "x <- 10"
    x = R.pull "x"
    assert_equal x, 10
  end

  def test_cran_existing_package_lookup
    WebMock.allow_net_connect!
    package = "vegan" # Exists
    response = open("http://cran.r-project.org/package=#{package}")
    assert_equal response.status, ["200", "OK"]
    WebMock.disable_net_connect!
  end

  def test_cran_missing_package_lookup
    WebMock.allow_net_connect!
    package = "vegantasticmachineblasternope" # Exists
    assert_raise(OpenURI::HTTPError, '404 Not Found') {
      response = open("http://cran.r-project.org/package=#{package}")
    }
    WebMock.disable_net_connect!
  end

  def test_getting_cran_package_metadata
    WebMock.allow_net_connect!
    package = "vegan" # Exists

    metadata = CodeCitations.metadata(package)
    assert_equal metadata,
    {
      "Version"=> "2.0-10",
      "Depends"=> "permute (≥ 0.8-0), lattice, R (≥ 2.15.0)",
      "Suggests"=> "MASS, mgcv, cluster, scatterplot3d, rgl, tcltk",
      "Published"=> "2013-12-12",
      "Author"=> "Jari Oksanen, F. Guillaume Blanchet, Roeland Kindt, Pierre Legendre,\nPeter R. Minchin, R. B. O'Hara, Gavin L. Simpson, Peter Solymos,\nM. Henry H. Stevens, Helene Wagner",
      "Maintainer"=> "Jari Oksanen  <jari.oksanen at oulu.fi>",
      "License"=> "GPL-2",
      "URL" => "http://cran.r-project.org, http://vegan.r-forge.r-project.org/",
      "NeedsCompilation"=> "yes",
      "Materials" => "NEWS ChangeLog",
      "In views" => "Environmetrics, Multivariate, Phylogenetics, Psychometrics, Spatial",
      "CRAN checks" =>"vegan results",
      "Reference manual" =>"vegan.pdf",
      "Vignettes" => "Design decisions and implementationDiversity analysis in veganIntroduction to ordination in vegan",
      "Package source" =>"vegan_2.0-10.tar.gz",
      "MacOS X binary" =>"vegan_2.0-10.tgz",
      "Windows binary" =>"vegan_2.0-10.zip",
      "Old sources" =>"vegan archive",
      "Reverse depends" => "analogue, betaper, bipartite, biplotbootGUI, blender, cocorresp, dave, FD, GUniFrac, iDynoR, isopam, loe, metacom, mpmcorrelogram, palaeoSig, paleoMAS, picante, recluster, rich, rioja, simba, SYNCSA, vegclust",
      "Reverse imports" => "Demerelate, forams, geomorph, MVPARTwrap, PopGenReport, poppr, soundecology, taxize, tspmeta",
      "Reverse suggests" => "betapart, BiodiversityR, codep, eHOF, entropart, mefa, multitable, permute, phylotools, primer, RnavGraph, spaa, vegdata, WeightedCluster, yaImpute"
    }
    WebMock.disable_net_connect!
  end
  # def test_example_real_network
  #   WebMock.allow_net_connect!
  #   assert_equal "Basic Modeling Approach To Optimize Elemental Imaging by Laser Ablation ICPMS",
  #     PaperMetadata.metadata_for('doi:10.1021/ac1014832')[:title]
  #   WebMock.disable_net_connect!
  # end

  # def test_example_webmocked
  #   arxiv_response = File.read(File.join(File.dirname(__FILE__), 'arxiv.xml'))
  #   stub_request(:any, /.*arxiv.org\/.*/).
  #     to_return(:body => arxiv_response, :status => 200,  :headers => { 'Content-Length' => arxiv_response.length } )
  #   assert_equal "Thomas Vojta",
  #     PaperMetadata.metadata_for('arXiv:1301.7746')[:authors]
  # end
end
