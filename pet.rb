require 'pg'


class Pet
  attr_accessor :name, :breed, :age, :attack_power
  attr_reader :id

  def initialize(name, breed, age, attack_power, id=nil)
    @name = name
    @breed = breed
    @age = age
    @attack_power = attack_power
    @id = id
  end

  def save
    sql = "INSERT INTO pets (name, breed, age, attack_power) VALUES ($1, $2, $3, $4);"
    self.class.conn.exec_params(sql, [@name, @breed, @age, @attack_power])
    true
  rescue PG::Error
    false
  end

  def destroy
    sql = "DELETE FROM pets WHERE id = $1;"
    self.class.conn.exec_params(sql, [@id])
    self # returns the object itself, used in the Rails ActiveRecord lib
  end

  # Class Methods

  def self.find(id)
    sql = "SELECT * FROM pets WHERE id = $1;"
    conn.exec_params(sql, [id]) do |response|
      result = response.values[0]
      # remember that the ID is the first result in the result array
      Pet.new(result[1], result[2], result[3], result[4], result[0])
    end
  rescue PG::Error
    nil
  end

  def self.all
    pets = []

    sql = "SELECT * FROM pets;"
    conn.exec(sql) do |response|
      response.values.each do |row|
        pets << Pet.new(row[1], row[2], row[3], row[4], row[0])
      end
    end

    pets
  end

  def self.conn
    PG.connect(dbname: 'w3d2')
  end

end
