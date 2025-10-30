#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"

echo "Enter your username:"
read USERNAME

#if username doesn't exists
username=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")
if [[ $username != $USERNAME ]]
then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    exists=false
    games_played=1
#else if username exists
else
    games_played=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME';")
    best_game=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME';")
    echo "Welcome back, $USERNAME! You have played $games_played games, and your best game took $best_game guesses."
    exists=true
fi

num=$(( RANDOM % 1000 + 1 ))
echo "Guess the secret number between 1 and 1000:"
read INPUT
number_of_guesses=1
while [[ $INPUT -ne $num ]] 
do
   
    if ! [[ $INPUT =~ ^-?[0-9]+$ ]] 
    then 
        echo "That is not an integer, guess again:"
        read INPUT
    elif [[ $INPUT -lt $num ]] 
    then
         (( number_of_guesses += 1 ))
        echo "It's higher than that, guess again:"
        read INPUT
    elif [[ $INPUT -gt $num ]] 
    then
        (( number_of_guesses += 1 ))
        echo "It's lower than that, guess again:"
        read INPUT
    fi
done

echo "You guessed it in $number_of_guesses tries. The secret number was $num. Nice job!"

#if first game
if [[  $exists == "false" ]]
then
    insert1=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES ('$USERNAME', $games_played, $number_of_guesses );")
#if played before
else
    (( games_played += 1 ))
    prev_best=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
    if [[ $number_of_guesses -gt $prev_best ]]
    then
      number_of_guesses=$prev_best
    fi
    insert2=$($PSQL "UPDATE users SET games_played=$games_played, best_game=$number_of_guesses WHERE username = '$USERNAME';")
fi
exit 0
