#!/bin/bash 
#
# TODO - Add a usage function 
# If no argument is given 
if [[ ${#} -eq 0 ]]
then
    echo "Please Supply an arugment" 
    # Add a usage function 
    exit 1
fi
COLOR=${1} 

# IF Hexadeicmal color code is provide 
# Break up number in pairs of 2 
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


