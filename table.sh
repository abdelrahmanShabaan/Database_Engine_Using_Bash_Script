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


        "List table")
            echo "--------------------------------------------------------"
            #Here we will use ls to list all files
            #and using grep (-v option to invert the match , non matching lines) | tr to replace / for spaces
            ls | grep -v '\.meta$' | tr '/' ' '
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;

        "Drop table")
            echo "--------------------------------------------------------"
            #Before make Drop we will show all tables in our Database directory
            #using grep (-v option to invert the match , non matching lines) 
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"

            #Make prompt to take name of table we want to delete
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            
            #make vaildations (if equal non-vaild name , we will display not allow)
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                    echo 
                    echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                    continue
                fi
            #If name of table is true make rm with (-r option) to remove table if not empty
            if [[ -f $name ]]; then
                rm -r "$name"
                rm -r "$name.meta"
                #After deleted we will display message this table is delete 
                echo "Table [$name] deleted successfully, Dr.Mina <3"
            else 
                echo "Sorry , Dr.Mina <3 ; There is an error, Can't find Table."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;

         "Insert row")
            echo "--------------------------------------------------------"
            #Before insert table we make sure to display tables all | to select from it
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            
            #start take name of table from user as prompt
            read -p "Please, Enter table Name, Dr.Mina <3 : " name

            #make if-condition with Regex to make sure name is vaild 
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi

            #Here we make variable save the name of table to use when insert 
            source_file="${name}"

            #Here we will use AWK with (-v option) to assign values to variables before awk execute
            #NR -> we will use for number of row we will make split in with argument of it 
            function getDatatype {
                awk -v col="$1" 'NR==2 {split($0, types, ":"); print types[col]}' "$name.meta"
            }

            #If Found file name start while looping of columns sequence
            if [[ -f $name ]]; then
                while true; do
                    #start prompt with (-p option) is handy for same line 
                    read -p "Please, Enter first columns value As PK, Dr.Mina <3: " id

                    #save is_unique in variable to use next steps 
                    is_unique=true
                    
                    # Check uniqueness of ID
                    # -we will use cut to extracting sections 
                    # -f: Selects fields (columns) based on a delimiter.
                    # -d: Specifies the delimiter used to separate fields.
                    # -c: Selects characters based on position.
                    for field in $(cut -f1 -d: "./$dbname/$name"); do
                        if [[ $field = "$id" ]]; then
                            echo "Sorry, Dr.Mina <3; ID is not unique. Please enter a unique ID."
                            is_unique=false
                            break
                        else is_unique=true
                        fi
                    done
                    #If the first columns Unique continue while loop
                    if [[ $is_unique == true ]]; then
                    #Then append in file with (-n option) to give it number of line
                        echo -n "$id : " >> "$source_file"
                        #start for loop to check datatype of column
                        for ((i=2; i<=$num_columns; i++)); do
                            read -p "Please, Enter Data for Column $i, Dr.Mina <3: " data
                            if [[ $data == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                                echo
                                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                                continue
                            fi

                            #Here we will use function that check of datatype we will insert in 
                            colDatatype=$(getDatatype "$i")
                            case $colDatatype in
                                    "<int> ")
                                        if ! [[ $data =~ ^[0-9]+$ ]]; then
                                            echo "Invalid Datatype, Dr.Mina <3."
                                            continue
                                        fi
                                        ;;
                                    "<str> ")
                                        if [[ $data =~ ^[0-9]+$ ]]; then
                                            echo "Invalid Datatype, Dr.Mina <3."
                                            continue
                                        fi
                                        ;;
                                esac
                            echo -n "$data : " >> "$source_file"
                        done
                        echo " " >> "$source_file"
                        break
                    fi
                done
                echo "Values inserted successfully, Dr.Mina <3."
                
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Please, Enter the name of an existing table."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;

        "Show data")
            echo "--------------------------------------------------------"
            #Before we select from table we will display all table to select from
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"

            while true; do
            #Then we will read table name as prompot from user
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                        echo 
                        echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                        continue
            fi
            if [[ ! -f $name ]]; then
            echo "Sorry , Dr.Mina <3 ; There is an error, Not Found."
                continue
            fi   
            break
            done

                echo
                echo -e "Dr.Mina <3 ; please choose: "
                echo    "1) Select all columns"
                echo    "2) Select Specific column"
                read choice
                case $choice in
                    1)
                        echo "*********** Table : $name ***********"
                        echo "----------------------------------"
                        #Here we will use AWK to display with columns 
                        #BEGIN block is executed before processing any input lines. 
                        #It sets the field separator (FS) to colon (:), 
                        #the output field separator (OFS) to a tab followed by a pipe (\t |), 
                        #the output record separator (ORS) to a newline.
                        awk 'BEGIN{FS=":";OFS="\t |";ORS="\n";}{ $1=$1; print substr($0, 1, length($0)-1) }' "./$name"
                        echo "----------------------------------"
                        ;;
                    2)
                        read -p "Enter the column numbers separated by commas (Example: 1,2,3): " columns
                        echo "*********** Table : $name ***********"
                        #Here we will use AWK with (-v option) to assign values to variables before awk execute
                        awk -v cols="$columns" 'BEGIN{FS=" : "; OFS="\t|"; ORS="\n";}
                        {
                            split(cols, arr, ",");
                            for(i=1; i<=length(arr); i++) {
                                printf "+----------------";
                            }
                            printf "+";
                            printf "\n";
                            for(i=1; i<=length(arr); i++) {
                                printf "|\t"$arr[i]"\t";
                            }
                            printf "|\n";
                        }' "./$name"
                        echo -n "+"
                        for ((i=1; i<=columns; i++)); do
                            echo -n "----------------+"
                        done
                        echo 
                        
                        ;;
                    *)
                    # (-e option ) allows to include \t and \n when make print 
                        echo -e "Sorry , Dr.Mina <3 ; Invalid Choice"
                        ;;
            esac
            echo
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;
        