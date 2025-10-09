#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


SERVICES=$($PSQL "SELECT service_id, name FROM SERVICES")

SERVICE_MENU() {
echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
    echo "$SERVICE_ID) $NAME"
done

echo -e "\nWhich service would you like? Input its number only."
read SERVICE_ID_SELECTED
SERVICE_NAME_PICKED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
echo $SERVICE_NAME_PICKED 

if [[ -z $SERVICE_NAME_PICKED ]]
then
      echo "Please enter a valid service_id"
      SERVICE_MENU
fi
}
