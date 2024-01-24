#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Main Menu: '

    #First we will Check if database is exist or not
    if [[ -d ././.db ]];
    then
        echo "--------------------------------------------------------"
        echo "Sorry , Dr.Mina <3 ; Datbase already exists"
        echo "--------------------------------------------------------"
        echo "Current Directory is: "
        echo "-----------------------"
        #IF Database initialization (print work directory)
        pwd
        echo "--------------------------------------------------------"
    else
        echo "--------------------------------------------------------"
        #make Database directory and print message of initialization 
        mkdir ./.db
        echo "DB Initiated successfully, Dr.Mina <3"
        echo "--------------------------------------------------------"
    fi
#make Select in Main Menu with all options
select var in "Create DB" "List DB" "Connect DB" "Remove DB" "Exit"
do 
    case $var in 
        "Create DB")
            echo "--------------------------------------------------------"
            #We will prompt database name from user
            read -p "Please, enter DB name, Dr.Mina <3 : " name

            #Check vaildation with Regex 
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi
            name=`echo $name | tr " " "_"`
            #Check vaildation here too with Regex 
            if [[ ! $name = [0-9]* ]];then
                if [[ -e ./.db/$name ]];then
                    echo "Sorry , Dr.Mina <3 ; Databse Already Exist"
                else 
                    #If name write with right syntx we need start make directory 
                    mkdir ./.db/$name 
                    #we will chmod to give access to modify on database 
                    chmod u+rwx ./.db/$name
                    #Print at the end database create successfully
                    echo "DB created successfully, Dr.Mina <3"
                fi
            else
                echo "Sorry , Dr.Mina <3 ; Invalid name, Please Try Again"
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create DB   3) Connect DB  5) Exit"
            echo "2) List DB     4) Remove DB"

        ;;

