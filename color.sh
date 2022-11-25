#!/bin/bash 
#
usage() {
    echo "$0 [OPTION] Value"
}

if [[ ${#} -eq 0 ]]
then
    echo "Please Supply an arugment" 
    usage
    exit 1
fi

# Get Options
# TODO Add Better options 
while [ "$#" -gt 1 ]
do 
    case "$1" in 
        -c) HEX=TRUE
            echo "This -c option was selected";;
        -w) RGB=TRUE ;;
        -*) echo "Going to attempt automatic conversion" 
            ;;
    esac
    shift
done

COLOR=${@}

if [[ ${HEX} ]] 
then
    RED=${COLOR:1:2}
    BLUE=${COLOR:3:2}
    GREEN=${COLOR:5:2}

    # Convert From Base 16
    BLUE=$(bc <<< "ibase=16; $BLUE")
    RED=$(bc <<< "ibase=16; $RED")
    GREEN=$(bc <<< "ibase=16; $GREEN")

    # Print Results
    printf "\x1b[38;2;${RED};${GREEN};${BLUE}mrgb(${RED}, ${GREEN}, ${BLUE})\x1b[0m\n"
    printf "\x1b[48;2;${RED};${GREEN};${BLUE}mrgb(${RED}, ${GREEN}, ${BLUE})\x1b[0m\n"


elif [[ $RGB ]]
then
    echo "I'll convert from RGB"
else 
    if [[ "${COLOR:0:1}" = "#" ]]
    then 
        RED=${COLOR:1:2}
        BLUE=${COLOR:3:2}
        GREEN=${COLOR:5:2}

        # Convert From Base 16
        BLUE=$(bc <<< "ibase=16; $BLUE")
        RED=$(bc <<< "ibase=16; $RED")
        GREEN=$(bc <<< "ibase=16; $GREEN")

        # Print Results
        printf "\x1b[38;2;${RED};${GREEN};${BLUE}mrgb(${RED}, ${GREEN}, ${BLUE})\x1b[0m\n"
        printf "\x1b[48;2;${RED};${GREEN};${BLUE}mrgb(${RED}, ${GREEN}, ${BLUE})\x1b[0m\n"

    else 
        # Will need to iterate through string from comma to comma 
        LENGTH=${#COLOR}
        RED=""
        GREEN=""
        BLUE="" 
        for (( c=0; c<=$LENGTH; c++ )) 
        do 
            if [[ ${COLOR:$c:1} = "," ]] || [[ $c = $LENGTH ]]
            then 
              #Change Color Variable  
              if [[ ${#RED} -eq 0 ]]
              then 
                  RED=$CURRENT 
                  CURRENT="" 
              elif [[ ${#GREEN} -eq 0 ]]
              then 
                  GREEN=$CURRENT
                  CURRENT=""
              elif [[ ${#BLUE} -eq 0 ]] 
              then
                  BLUE=$CURRENT 
                  CURRENT=""
              else 
                  echo "There was an error, I dunno"
              fi
            else 
                CURRENT=$CURRENT${COLOR:$c:1}
            fi
        done
        # Convert base 10 to base 16
        HBLUE=$(bc <<< "ibase=10; obase=16; $BLUE")
        HRED=$(bc <<< "ibase=10; obase=16; $RED")
        HGREEN=$(bc <<< "ibase=10; obase=16; $GREEN")
        printf "\x1b[38;2;${RED};${GREEN};${BLUE}m#${HRED}${HGREEN}${HBLUE}\x1b[0m\n"
        printf "\x1b[48;2;${RED};${GREEN};${BLUE}m#${HRED}${HGREEN}${HBLUE}\x1b[0m\n"


    fi
fi


