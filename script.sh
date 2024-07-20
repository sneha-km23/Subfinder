#!/bin/bash

# ANSI color codes for better presentation
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
# Spinner function for displaying a loading animation
spinner() {
    local pid=$1
    local delay=0.15
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        printf "%c" "${spinstr:i++%${#spinstr}:1}"
        sleep $delay
        printf "\b"
    done
    printf " \b"
}
s
# "Please wait a minute" animation function
wait_animation() {
    local delay=1
    local message="Please wait a minute"
    printf "${CYAN}"
    while true; do
        printf "%s" "$message"
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
        printf "                  " # Clears the line
        sleep $delay
    done
}

# Function to validate domain format
validate_domain() {
    local domain=$1
    # Regex to check if domain is valid
    if [[ "$domain" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0 # Valid domain
    else
        return 1 # Invalid domain
    fi
}

# Display script header and ASCII art banner
echo -e "${CYAN}Subdomain Finder and Live Checker Tool${NC}"
echo "=================================================================="
echo "                                ___.    
  ________ ________   __________\_ |__  
 /  ___/  |  \____ \_/ __ \_  __ \ __ \ 
 \___ \|  |  /  |_> >  ___/|  | \/ \_\ 
/____  >____/|   __/ \___  >__|  |___  /
     \/      |__|        \/          \/ "
echo ""

while true; do
    # Prompt user for domain input
    read -p "$(echo -e "${YELLOW}Enter your domain:${NC} ")" domain

    # Check if domain is empty
    if [ -z "$domain" ]; then
        echo -e "${RED}Please enter a domain.${NC}"
        continue
    fi

    # Validate domain format
    if ! validate_domain "$domain"; then
        echo -e "${RED}Enter a valid domain.${NC}"
        continue
    fi

    echo -e "${CYAN}Target domain:${NC} $domain"

    # Confirm domain input
    read -p "$(echo -e "${YELLOW}Proceed with scanning? (yes/no):${NC} ")" confirmation

    if [ "$confirmation" != "yes" ]; then
        echo -e "${RED}Aborting script${NC}"
        exit 1
    fi

    # Start "Please wait a minute" animation
    wait_animation &
    wait_pid=$!

    # Find subdomains using assetfinder
    echo -e "${CYAN}Finding subdomains for $domain${NC}"
    assetfinder "$domain" > subs &
    spinner $!
    echo ""

    # Check live subdomains using httprobe
    echo -e "${CYAN}Checking for live subdomains${NC}"
    cat subs | httprobe > live &
    spinner $!
    echo ""

    # Stop "Please wait a minute" animation
    kill $wait_pid > /dev/null 2>&1

    # Sort and display live subdomains
    sort -u live > sorted
    echo -e "${GREEN}Live subdomains:${NC}"
    cat sorted

    # Prompt user to continue with another domain
    read -p "$(echo -e "${YELLOW}Do you want to continue with another domain? (yes/no):${NC} ")" continue

    if [ "$continue" != "yes" ]; then
        echo -e "${CYAN}Exiting script${NC}"
        break
    fi
done

# ASCII art after the loop
echo -e "${CYAN}"
cat << "EOF"
                                 
                                 
                                 
                           ,---, 
               ,---,     ,---.'| 
           ,-+-. /  |    |   | : 
   ,---.  ,--.'|'   |    |   | | 
  /     \|   |  ,"' |  ,--.__| | 
 /    /  |   | /  | | /   ,'   | 
.    ' / |   | |  | |.   '  /  | 
'   ;   /|   | |  |/ '   ; |:  | 
'   |  / |   | |--'  |   | '/  ' 
|   :    |   |/      |   :    :| 
 \   \  /'---'        \   \  /   
  ----'               ----'    
EOF
echo -e "${NC}"
