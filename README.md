W3D2 - Homebrewed ORM
==============================

ORM == "Object Relational Mapper"

When we write code in Ruby we think and use *objects*. However when we
write code for relational databases when use *SQL* which is text
based. Wouldn't it be nice to write database code and values using
*objects* instead of text.

Well you can! Today we are going to write our own *basic*, and I mean
basic *ORM*.

There are 2 basic types of ORMs out there that implement the following
two patterns: *Datamapping* and *ActiveRecord*. You can find more
information about the two patterns here:

* ActiveRecord: https://en.wikipedia.org/wiki/Active_record_pattern
* DataMapper:
* Differences:
http://culttt.com/2014/06/18/whats-difference-active-record-data-mapper/

Today we are going to focus on the ActiveRecord pattern since it is
more common in the Ruby/Python/Javascript world. We are going to show
how to create a naive trivial class that represents Lighthouse Pets.

Step 1
-------

For step 1 lets create a schema for our Pet Object. We are going to
write it in SQL.

schema.sql
```SQL
CREATE TABLE pets(
  id   serial NOT NULL PRIMARY KEY,
  name   varchar(255) NOT NULL,
  breed  varchar(255),
  age    integer,
  attack_power integer
);
```


Requirements
--------------

To do this exercise we need to have PostgreSQL installed.

You also need to have a database created called 'w3d2'.
