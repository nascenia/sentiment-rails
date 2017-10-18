# Sentiment Rails 
A chat application which understands emotions & communication style using IBM Watson Tone Analyzer API

## Setup guide

1. System dependencies
    - Ruby 2.3
    - Rails 5
    - Redis

2. `rake db:create && rake db:migrate`
3. `rake db:seed`
4. `redis-server`
5. `rails server`

## Setup IBM Watson

Add credentials of IBM Watson account in `config/secrets.yml` based on environment.


