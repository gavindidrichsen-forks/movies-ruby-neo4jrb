source "https://rubygems.org"

gem 'bundle'
# Note that 'aws-sdk' pulls in a large number of libraries, choose explicitly those to include instead
# gem 'aws-sdk', '~> 3'
#
# See service list here: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html
#
# See train-aws for a list of dependencies already available: https://github.com/inspec/train-aws/blob/master/train-aws.gemspec
# Note if the gem required is commented out, please raise a PR against the train-aws repo first
# In the mean time the gem can be added here for local development

# Use Latest Inspec
# gem 'inspec-bin'

gem 'rubocop', require: false
gem 'sinatra'
gem 'neo4j'
gem 'shotgun'
gem 'activegraph' #, '>= 10.0.0' # For example, see https://rubygems.org/gems/activegraph/versions for the latest versions
gem 'neo4j-ruby-driver'

group :development do
  gem 'rake'
  gem 'minitest'
  gem 'rspec'
  gem 'pry-byebug'
  
  gem 'guard'
  gem 'guard-shell'
  gem 'guard-rspec'
end
