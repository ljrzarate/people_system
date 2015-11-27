# People System

This application is intended to be useful to whoever need a system to manage people, with this application easily can add persons to the system and the member will recieve an email when a new person is created and also when a person is deleted


## Technologies

1. Rails 4.2.4
2. Ruby 2.2.3
3. Resque
4. Redis

## Installation Proces

### Mac OS X

* install [homebrew](http://brew.sh/)
* run `brew install git`
* run `brew install redis`
* run `brew install mysql`
* clone [the repo](git@github.com:ljrzarate/people_system.git)
* run `bundle install` in the project folder
* run redis-server
* make sure the database is up and running
* run `rake db:create`
* run `rake db:migrate`
* run `rails s`

