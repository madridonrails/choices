# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_choices_session',
  :secret      => '23a2c9708c2a18c67df15bcb41916a15469ad8cb11e2c7c30cab82d5f26ad851f447ba273f60a4a5f6456e6fd4e1daff8f9d32e492ba9df0d33d2d8a0cdf3e95'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
