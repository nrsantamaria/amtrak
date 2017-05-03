CREATE DATABASE amtrak;

\c amtrak

CREATE TABLE "trains" (
"id"  SERIAL ,
"name" VARCHAR ,
PRIMARY KEY ("id")
);

CREATE TABLE "stops" (
"id"  SERIAL ,
"train_id" INTEGER ,
"city_id" INTEGER ,
"arrival_time" TIME ,
"arrival_date" DATE ,
PRIMARY KEY ("id")
);

CREATE TABLE "cities" (
"id"  SERIAL ,
"name" VARCHAR ,
PRIMARY KEY ("id")
);

\c Guest

CREATE DATABASE amtrak_test WITH TEMPLATE amtrak;
