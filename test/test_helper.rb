require 'webmock/test_unit'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
end