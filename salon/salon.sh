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

MAIN_MENU() {
  SERVICE_MENU
  
  echo -e "\nwhat is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
      echo "whats your name"
      read CUSTOMER_NAME
      echo "what time would u like your service?"
      read SERVICE_TIME
      INSERT_CUSTOMER_DETAILS=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
      echo "I have put you down for a $SERVICE_NAME_PICKED at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}


MAIN_MENU
