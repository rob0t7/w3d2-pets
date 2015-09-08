W3D2 - Homebrewed ORM
==============================

ORM == "Object Relational Mapper"

When we write code in Ruby we think and use **objects**. However when we
write code for relational databases when use **SQL** which is text
based. Wouldn't it be nice to write database code and values using
**objects** instead of text.

Well you can! Today we are going to write our own **basic**, and I mean
basic **ORM**.

We can now think of a **class** representing a **table** in the DB. And an
**instance** of the class representing a specific **row** in the DB.

There are 2 basic types of ORMs out there that implement the following
two patterns: **Datamapping** and **ActiveRecord**. You can find more
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


Step 2 - Create Database Records
-------------------------------------

Lets create the basic Pet object and implement the first step in CRUD
(i.e. the 'C').

pet.rb

```RUBY
require 'pg'


class Pet
  attr_accessor :name, :breed, :age, :attack_power

  def initialize(name, breed, age, attack_power, id=nil)
    @name = name
    @breed = breed
    @age = age
    @attack_power = attack_power
  end

  def save
    sql = "INSERT INTO pets (name, breed, age, attack_power) VALUES ($1, $2, $3, $4)"
    connection = PG.connect(dbname: 'w3d2')
    connection.exec_params(sql, [@name, @breed, @age, @attack_power])
    true
  rescue PG::Error
    false
  end

end

```

Step 3 - Fetch 1 record by ID
---------------------------------

Lets implement the Pet#find function so we can retrieve a specific
record from the DB. Notice that this is a class method, and the return
value is an instance of Pet

Also allowed the Pet instance to have an Id field.

PG returns values in the form of an array of arrays (think 2D) where
the arrays that are stored represent a row in the DB and the coloumn
are in the position that they are defined in the schema.

See the Diff to see what we did for this step.

Step 4 - Fetch all the records
----------------------------------

To fetch all the records we are going to implement the following
function **Pet.all**. This function will return an array of Pet
objects.

Requirements
--------------

To do this exercise we need to have PostgreSQL installed.

You also need to have a database created called 'w3d2'.
