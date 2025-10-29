#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit 0 ##this makes it finish running
fi


if [[ $1 == "H" || $1 == 1 || $1 == "Hydrogen" ]]
then
echo "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
exit 0
fi


#if number
if [[ $1 =~ ^[0-9]+$ ]]
#return sentence using atomic_number
then 
    atomic_num=$1
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number = $atomic_num")
    if [[ -z $name ]]
    then 
    echo "I could not find that element in the database."
    exit 0
    fi
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $atomic_num")
    type_id=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $atomic_num")
    type=$($PSQL "SELECT type FROM types WHERE type_id = $type_id")
    atomic_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $atomic_num")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    echo "The element with atomic number $atomic_num is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
    exit 0

#if symbol
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
#return sentence using symbol
then
    symbol=$1
    atomic_num=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$symbol'")
    if [[ -z $atomic_num ]]
    then 
    echo "I could not find that element in the database."
    exit 0
    fi
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number = $atomic_num")
    type_id=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $atomic_num")
    type=$($PSQL "SELECT type FROM types WHERE type_id = $type_id")
    atomic_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $atomic_num")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    echo "The element with atomic number $atomic_num is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
    exit 0
#if name
elif [[ $1 =~ ^[a-zA-Z]+$ ]]
#return sentence using name
then
    name=$1
    atomic_num=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$name'")
    if [[ -z $atomic_num ]]
    then 
    echo "I could not find that element in the database."
    exit 0
    fi
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $atomic_num")
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number = $atomic_num")
    type_id=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $atomic_num")
    type=$($PSQL "SELECT type FROM types WHERE type_id = $type_id")
    atomic_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $atomic_num")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $atomic_num")
    echo "The element with atomic number $atomic_num is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
    exit 0
fi



