# Define some colors first:
source colors.inc
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

COLS="`stty size 2> /dev/null`"
COLS="`getcols ${COLS}`"
COLS=$((${COLS} - 1))

function drawline() {
  NR=${1:-79}
  CHAR=${2:-"-"}
  FRONTCOLOR=${3:-${WHITE}}
  BACKCOLOR=${4:-}
  echo -ne "${BACKCOLOR}${FRONTCOLOR}"
  for ((i=0; i<${NR}; i++)); do echo -n ${CHAR}; done
  echo -e "${NC}"
}

# Looks best on a black background.....
drawline ${COLS} "=" ${RED}
echo -e "\n${CYAN}Dit is BASH ${RED}${BASH_VERSION%.*}${NC}\n"
echo -e "${YELLOW}Welkom, ${USER}!${NC}\n"
echo -e "${blue}Vandaag is het: `date "+%A, %d %B %Y"`${NC}"
drawline ${COLS} "-" ${RED}

function _exit()
{
    echo -e "${RED}Hasta la vista, baby${NC}"
}
trap _exit EXIT
