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