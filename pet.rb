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
