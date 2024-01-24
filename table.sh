#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Table Menu: '
cd ./.db/$1

select var in "Create table" "List table" "Drop table" "Insert row" "Show data" "Delete row" "Update cell" "Exit"
do 
    case $var in
       "Create table")
            #read input of table name from user and save in {name}
            read -p "Please, Enter table Name, Dr.Mina <3 : " name

            #make if condition to vaild that name of file not be anything other character
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi

            #Use tr to repleace any space with underscores of name of table  
            name=`echo "$name" | tr " " "_"`            

            #make another Regex that must consists only of letters and underscores
            if [[ $name =~ ^[a-zA-Z_]+$  ]]; then
                #check if file is already exist or Not
                if [[ -f ./$dbname/$name ]]; then
                    echo "Sorry , Dr.Mina <3 ; There is an error, Table '$name' Already Exists."
                else 
                    #Ask user to enter this prompt of number of Columns 
                    read -p "Please, Enter Count Columns, Dr.Mina <3: " num_columns

                    #make touch to create file
                    touch ./$dbname/$name
                    
                    #make chmod to give all access to modify table of database
                    chmod u+rwx ./$dbname/$name