#!/bin/bash 
#
usage() {
    echo "$0 [OPTION] Value"
    echo 
    echo "Options:"
    echo 
    echo " -c"
    echo "convert Hexidemical to RGB"
    echo 
    echo " -r"
    echo "convert RGB to Hexidemcial"
}
# TODO - Decide how to handle conversion.
# TODO - Create Functions to handle converions.


# If no argument is given 
if [[ ${#} -eq 0 ]]
then
    echo "Please Supply an arugment" 
    usage
    exit 1
fi
# If check to see how many arguments are given and assign the color variable 
if [[ ${#} -eq 1 ]]
then 
    COLOR=${1}
else
    COLOR=${2}
fi

## Get Options 
while [ "$#" -gt 0 ]
do 
    case "$1" in 
        -c) HEX=TRUE ;;
        -w) RGB=TRUE ;;
        -*) echo "Going to attempt automatic conversion" 
            ;;
    esac
    shift
done

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
        echo "I'm going to convert this here hexidemical"
    else 
        echo "I'm going to convert this RGB value"
    fi
fi


