
# Amtrak

#### By _**Nicole Santamaria** and **Mohamed Warsame**_

## Description
An app to track train schedule. Many-to-many relationship database system.

### Prerequisites

* Web browser with ES6 compatibility
Examples: Chrome, Safari
* Ruby
* Bundler

### Installing

* Clone repository: `$ git clone https://github.com/nrsantamaria/amtrak`
* Navigate to folder: `$ cd amtrak`
* Install gems: `$ bundle install`
* In a separate tab start postgres: `$ postgres`
* Set up the database: `$ rake db:create`
* Create tables: `$ rake db:migrate db:test:prepare`
* Start server: `$ ruby app.rb`
* In your browser visit: `localhost:4567`

## Built With

* Ruby
* Sinatra
* PSQL
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/

## Helpful Tips

* In the terminal enter the command `$ psql ` and use the following commands:
```
CREATE DATABASE amtrak;

\c amtrak

CREATE TABLE "trains" ( "id" SERIAL , "name" VARCHAR , PRIMARY KEY ("id") );

CREATE TABLE "stops" ( "id" SERIAL , "train_id" INTEGER , "city_id" INTEGER , "arrival_time" TIME , "arrival_date" DATE , PRIMARY KEY ("id") );

CREATE TABLE "cities" ( "id" SERIAL , "name" VARCHAR , PRIMARY KEY ("id") );

\c Guest

CREATE DATABASE amtrak_test WITH TEMPLATE amtrak;
```

## Known Bugs

_Does not route properly_

## Support and contact details

_Please contact Nicole Santamaria at NicoleRSantamaria@gmail.com if you have any questions._


### License

*This software is licensed under MIT license.*

Copyright (c) 2017 **_Nicole Santamaria_**
