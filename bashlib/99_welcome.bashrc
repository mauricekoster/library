# Define some colors first:
#if [ -z $RED ]; then
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'
#fi
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

# Looks best on a black background.....
echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${NC}\n"

function _exit()
{
    echo -e "${RED}Hasta la vista, baby${NC}"
}
trap _exit EXIT

