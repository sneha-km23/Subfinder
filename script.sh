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

# Check for required commands
for cmd in assetfinder httprobe; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}$cmd could not be found. Please install it to use this script.${NC}"
        exit 1
    fi
done

# Display script header and ASCII art banner
echo -e "${CYAN}Subdomain Finder and Live Checker Tool${NC}"
echo "=================================================================="
echo " _______           ______     _______ _________ _        ______   _______  _______ "
echo "(  ____ \|\     /|(  ___ \   (  ____ \ \__   __/( (    /|(  __  \ (  ____ \(  ____ )"
echo "| (    \/| )   ( || (   ) )  | (    \/   ) (   |  \  ( || (  \  )| (    \/| (    )|"
echo "| (_____ | |   | || (__/ /   | (__       | |   |   \ | || |   ) || (__    | (____)|"
echo "(_____  )| |   | ||  __ (    |  __)      | |   | (\ \) || |   | ||  __)   |     __)"
echo "      ) || |   | || (  \ \   | (         | |   | | \   || |   ) || (      | (\ (   "
echo "/\____) || (___) || )___) )  | )      ___) (___| )  \  || (__/  )| (____/\| ) \ \__"
echo "\_______)(_______)|/ \___/   |/       \_______/|/    )_)(______/ (_______/|/   \__/"
                                                                                   
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

    # Find subdomains using assetfinder
    echo -e "${CYAN}Finding subdomains for $domain${NC}"
    assetfinder "$domain" > subs &
    assetfinder_pid=$!
    spinner $assetfinder_pid
    echo ""

    # Check live subdomains using httprobe
    echo -e "${CYAN}Checking for live subdomains${NC}"
    cat subs | httprobe > live &
    httprobe_pid=$!
    spinner $httprobe_pid
    echo ""

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
    ______                __   ____           
  / ____/___  ____  ____/ /  / __ )__  _____ 
 / / __/ __ \/ __ \/ __  /  / __  / / / / _ \
/ /_/ / /_/ / /_/ / /_/ /  / /_/ / /_/ /  __/
\____/\____/\____/\__,_/  /_____/\__, /\___/ 
                                /____/       
EOF
echo -e "${NC}"
