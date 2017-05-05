# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
WATSON_USER = Rails.application.secrets.watson_user
WATSON_PASSWORD = Rails.application.secrets.watson_password
