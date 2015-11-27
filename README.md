# People System

This application is intended to be useful to whoever need a system to manage people, with this application easily can add persons to the system and the member will recieve an email when a new person is created and also when a person is deleted


## Technologies

1. Rails 4.2.4
2. Ruby 2.2.3
3. Resque
4. Redis

## Installation Proces

## Mac OS X

* install [homebrew](http://brew.sh/)
  * run `brew install git`
  * run `brew install redis`
  * run `brew install mysql`
* clone this repo
* run `bundle install` in the project folder
* make sure the database is up and running
* run `rake db:create`
* run `rake db:migrate`
* run `rake db:seed`
* gem install mailcatcher
* run `mailcatcher`

### Running Manually

* run `redis-server`
* run `rake environment resque:work QUEUE=*`
* run `rails s`

### Runnung with Foreman
information [here](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html)
* gem install foreman
* foreman start

