#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Table Menu: '
cd ./.db/$1

select var in "Create table" "List table" "Drop table" "Insert row" "Show data" "Delete row" "Update cell" "Exit"
do 
    case $var in
        "Create table")
            #read input of table name from user and save in {name}
            read -p "Please, Enter table Name, Dr.Mina <3 : " name

esac