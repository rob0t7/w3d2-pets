require_relative 'pet'

fido = Pet.new('Fido', 'dog', 2, 2)
fido.save # This save the values in the db.

my_stored_pet = Pet.find(1)
my_stored_pet.name == fido.name
