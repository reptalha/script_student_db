#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
while IFS=',' read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != 'year' ]];
  then

  #insert teams

    #get teams
    team1=$winner
    team2=$opponent

    #check if winner in db
    name1=$($PSQL "SELECT name FROM teams WHERE name='$team1'")
    #if not, add it
    if [[ -z $name1 ]]
    then 
    insert_team_result=$($PSQL "INSERT INTO teams(name) VALUES('$team1')")
    fi

    #check if opp in db
    name2=$($PSQL "SELECT name FROM teams WHERE name='$team2'")
    #if not, add it
    if [[ -z $name2 ]]
    then 
    insert_team_result=$($PSQL "INSERT INTO teams(name) VALUES('$team2')")
    fi


  #insert games

    #get winner_id
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    #get opponent_id
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    
    #insert all
    insert_team_result=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id)
     VALUES('$year', '$round', '$winner_goals', '$opponent_goals', $winner_id, $opponent_id)")



  fi
done < games.csv
