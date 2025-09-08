README
Overview

This Bash script loads data from courses.csv and students.csv into the students PostgreSQL database. It ensures majors, courses, and students are properly inserted, creating relationships between them.

How it works

Clears old data using TRUNCATE.

Reads courses.csv:

Inserts new majors and courses if they don’t exist.

Creates entries in the majors_courses join table.

Reads students.csv:

Inserts each student with their major (or NULL if no match).

Prints messages when new records are inserted.

Usage

Make the script executable and run it:

chmod +x insert_data.sh
./insert_data.sh


Make sure:

You have a PostgreSQL user (my user which you won't be seeing :( ) with access to the students database.

The students, majors, courses, and majors_courses tables already exist.

courses.csv and students.csv are in the same directory.
