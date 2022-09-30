#! /bin/bash

# echo -e "\n\n~~~~ Periodic Table ~~~~\n\n"

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #get element using argument
  element_by_an=$($PSQL "select * from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
  # element_by_symbol=$($PSQL "select * from elements join properties using(atomic_number) join types using(type_id) where symbol = '$1'")
  # element_by_name=$($PSQL "select * from elements join properties using(atomic_number) join types using(type_id) where name = '$1'")

  #if argument is atomic number
  if [[ $element_by_an ]]
  then
    mp=$($PSQL "select melting_point_celsius from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
    bp=$($PSQL "select boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
    name=$($PSQL "select name from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
    symbol=$($PSQL "select symbol from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
    type=$($PSQL "select type from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
    mass=$($PSQL "select atomic_mass from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")

    echo "The element with the atomic number $1 is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $mp celsius and a boiling point of $bp celsius."
  fi
fi

