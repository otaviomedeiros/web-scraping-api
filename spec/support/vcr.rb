VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join("spec", "vcr")
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description]
    VCR.use_cassette(name) { example.call }
  end
end
