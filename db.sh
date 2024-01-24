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

        "List DB")
            echo "--------------------------------------------------------"
            #Here we will use ls (-F option) to list all directory | grep any slash | replace any / with space 
            ls -F ./.db | grep / | tr '/' ' '
            echo
            echo "--------------------------------------------------------"
            echo "1) Create DB   3) Connect DB  5) Exit"
            echo "2) List DB     4) Remove DB"
        ;;

        
        "Connect DB")
                echo "************ Existing Databases ************"
                #check with If condition if (e option) include special characters in output 
                if [[ -e ./.db ]]; then
                    ls -F ./.db | grep / | tr '/' ' '
                    echo "--------------------------------------------------------"
                    #read prompt from user of name of database we want to connect on
                    read -p "Please, enter DB name, Dr.Mina <3 : " name
                    
                    #After read prompt check regex if name have any non-Vaild symbols
                    if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                        echo 
                        echo "! @ # $ % ^ () + . -  are not allowed!"
                        continue
                    fi
                    #IF all things is good connect to database
                    if [[ -d ./.db/$name ]]; then
                        
                        #Display success message we are connecting
                        echo "Connecting to $name...."
                        #use chmod to give all access to Modify of database 
                        chmod u+rwx ./.db/$name
                        ./table.sh $name
                        #print at the end (print work directory)
                        pwd
                        echo "--------------------------------------------------------"
                    else
                        echo "Sorry , Dr.Mina <3 ; Database $name doesn't exist."
                        echo "--------------------------------------------------------"
                    fi
                fi
                echo
                echo "--------------------------------------------------------"
                echo "1) Create DB   3) Connect DB  5) Exit"
                echo "2) List DB     4) Remove DB"
        ;;

