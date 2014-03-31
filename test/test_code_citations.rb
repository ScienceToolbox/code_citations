require 'test/unit'
require 'code_citations'
require 'test_helper'
require 'rinruby'

class CodeCitationsTest < Test::Unit::TestCase
  def test_r_integration
    R.eval "x <- 10"
    x = R.pull "x"
    assert_equal x, 10
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
