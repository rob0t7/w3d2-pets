CREATE TABLE pets(
  id   serial NOT NULL PRIMARY KEY,
  name   varchar(255) NOT NULL,
  breed  varchar(255),
  age    integer,
  attack_power integer
);
