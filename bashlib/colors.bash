# Define some colors first:
black='\e[0;30m'
BLACK='\e[1;30m'
BACK_black='\e[40m'

red='\e[0;31m'
RED='\e[1;31m'
BACK_red='\e[41m'

green='\e[0;32m'
GREEN='\e[1;32m'
BACK_green='\e[42m'

yellow='\e[0;33m'
YELLOW='\e[1;33m'
BACK_yellow='\e[43m'

blue='\e[0;34m'
BLUE='\e[1;34m'
BACK_blue='\e[44m'

magenta='\e[0;35m'
MAGENTA='\e[1;35m'
BACK_magenta='\e[45m'

cyan='\e[0;36m'
CYAN='\e[1;36m'
BACK_cyan='\e[46m'

white='\e[0;37m'
WHITE='\e[1;37m'
BACK_white='\e[47m'

# 38, 39 unused/not defined/does not exit/is same as white
NC='\e[0m'              # No Color

show_colors()
{
    echo     "        clr  / CLR  / back"
    echo -ne "Black   ${black}${BACK_white}XXXX${NC} / ${BLACK}XXXX${NC} "
    echo -e  "/ ${BACK_black}....${NC}"
    
    echo -e "Red     ${red}XXXX${NC} / ${RED}XXXX${NC} / ${BACK_red}    ${NC}"
    echo -e "Green   ${green}XXXX${NC} / ${GREEN}XXXX${NC} / ${BACK_green}    ${NC}"
    echo -e "Yellow  ${yellow}XXXX${NC} / ${YELLOW}XXXX${NC} / ${BACK_yellow}    ${NC}"
    echo -e "Blue    ${blue}XXXX${NC} / ${BLUE}XXXX${NC} / ${BACK_blue}    ${NC}"
    echo -e "Magenta ${magenta}XXXX${NC} / ${MAGENTA}XXXX${NC} / ${BACK_magenta}    ${NC}"
    echo -e "Cyan    ${cyan}XXXX${NC} / ${CYAN}XXXX${NC} / ${BACK_cyan}    ${NC}"
    echo -e "White   ${white}XXXX${NC} / ${WHITE}XXXX${NC} / ${BACK_white}    ${NC}"
}
declare +x show_colors
