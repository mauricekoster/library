error() {
    echo -e " ${BAD}*${NORMAL} ${*}"
}

warning() {
    echo -e " ${WARN}*${NORMAL} ${*}"
}

info() {
    echo -e " ${GOOD}*${NORMAL} ${*}"
}

infon() {
    echo -ne " ${GOOD}*${NORMAL} ${*}"
}

debug() {
    echo -e " ${DEBUGCLR}*${NORMAL} ${*}"
}

begin() {
    echo -e " ${GOOD}*${NORMAL} ${*}..."
}

end_ok() {
    echo -e "${ENDCOL}  ${BRACKET}[ ${GOOD}ok${BRACKET} ]${NORMAL}"
}

end_nok() {
    echo -e "${ENDCOL}  ${BRACKET}[ ${BAD}!!${BRACKET} ]${NORMAL}"
    
	if [ "$#" -ge 2 ]
	then
        local errno=$1
		shift
		error "${*} ($errno)"
	fi
    
}

end() {
    if [ "$#" -eq 0 ] || ([ -n "$1" ] && [ "$1" -eq 0 ])
	then
       end_ok $*
    else
        retval="$1"
		
        end_nok $*

	return ${retval}

    fi
    return 0
}

progress()
{
    P=$1
    PROGRESS_BLOCKS=`expr $P / 2`
    SPACES="                                                  " 
    MSG=${MSG:-"Progress ${P}%"}
    
    echo -ne "\r ${WHITE}*${NC} ${MSG:0:20} : "
    i=$PROGRESS_BLOCKS
    echo -ne "${BACK_yellow}${SPACES:0:$i}"
    
    i=`expr 50 - $PROGRESS_BLOCKS`
    echo -ne "${BACK_blue}${SPACES:0:$i}"

    echo -ne "${NC}"

    if [ $P -ge 100 ]
    then
        echo -ne "\r${SPACES}${SPACES:0:26}"
        echo -e "\r ${WHITE}*${NC} ${MSG:0:20} : Done"
    fi
}

##########################################################################
## Initialisation

if [ "${BASH_VERSION}" = "" ]
then
    error_default "Mode fancy won't work without BASH"
    return 127
else

getcols() {
	echo "$2"
}


if [ "$(/sbin/consoletype 2> /dev/null)" = "serial" ]
then
    # We do not want colors on serial terminals
    NOCOLOR="yes"
fi

if [ "${NOCOLOR:-no}" = "yes" ]
then
	COLS="71"
	ENDCOL=

	TITLEBRD=
	TITLECLR=
	GOOD=
    DEBUGCLR=
	WARN=
	BAD=
	NORMAL=
	HILITE=
	BRACKET=
	
else
	COLS="`stty size 2> /dev/null`"
	COLS="`getcols ${COLS}`"
	COLS=$((${COLS} - 8))
	ENDCOL=$'\e[A\e['${COLS}'G'    # Now, ${ENDCOL} will move us to the end of the
	                               # column;  irregardless of character width
	
	TITLEBRD=$'\e[0;32m'
	TITLECLR=$'\e[1;32m'
	GOOD=$'\e[32;01m'
	WARN=$'\e[33;01m'
	BAD=$'\e[31;01m'
    DEBUGCLR=$'\e[34;01m'
	NORMAL=$'\e[0m'
	HILITE=$'\e[36;01m'
	BRACKET=$'\e[34;01m'
fi

fi # if BASH
