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

                    #start declearation of array , that will have looping his columns 
                    arr=()

                    #for looping in num_columns that prompt from user
                    for ((i=1; i<=$num_columns; i++)); do
                        #start read number sequence and give name then datatype then save in table
                        read -p "Please,Enter Column [$i] Name, Dr.Mina <3: " col

                        #select datatype after take name of first column
                        select data in "Integer" "String"
                        do
                            case $data in
                                "Integer" ) datatype+="<int> :"; break;;
                                "String" ) datatype+="<str> :"; break;;
                                * ) 
                            echo "Sorry , Dr.Mina <3 ; Invalid Choice"
                            echo "--------------------------------------------------------";;
                            esac
                        done

                    #Here i will use (-n option) for line number then append >> save in file with .meta
                    echo -n " $col : " >> $name.meta
                    done
                    echo "" >> $name.meta
                    echo -n "$datatype" >> $name.meta
                    echo "Table '$name' created successfully, Dr.Mina <3."
                fi
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Invalid name."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;
