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
