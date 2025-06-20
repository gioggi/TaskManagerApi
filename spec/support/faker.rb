# Configure Faker for consistent test data
RSpec.configure do |config|
  # Set a fixed seed for Faker so that random data is consistent across test runs
  Faker::Config.random = Random.new(42)
end
