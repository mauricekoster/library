##########################################################################
##
#   Default fallback function (if no mode is defined)
#

error_default() {
    echo "ERROR : $*" >&2
}

warning_default() {
    echo "warning : $*"
}

info_default() {
    echo "info : $*"
}

infon_default() {
    echo -n "info : $*"
}

debug_default() {
    echo "debug : $*"
}

begin_default() {
    echo -n "> $*... "
}

end_ok_default() {
    echo "[ok]"
}

end_nok_default() {
    echo "[!!]"
    
	if [ "$#" -ge 2 ]
	then
        local errno=$1
		shift
		error "${*} ($errno)"
	fi
    
    echo
}

progress_default() {
    P=$1
    PROGRESS_BLOCKS=`expr $P / 2`
    FULL="##################################################" 
    EMPTY=".................................................." 

    MSG=${MSG:-"Progress ${P}%"}
    
    echo -ne "\r * ${MSG:0:20} : "
    i=$PROGRESS_BLOCKS
    echo -ne "${FULL:0:$i}"
    
    i=`expr 50 - $PROGRESS_BLOCKS`
    echo -ne "${EMPTY:0:$i}"

    if [ $P -ge 100 ]
    then
        echo -ne "\r${SPACES}${SPACES:0:26}"
        echo -e "\r * ${MSG:0:20} : Done"
    fi
}

help_default() {
    echo "MODE default
"
}

#end_default
MODELOADED_default=yes

##########################################################################
##
#   The worker function
#

__do_it() {
    func=$1
    shift
    
    M=${MODE:-""}
    M=$(echo $M | sed -e 's/[;:]/ /g')

    for mode in ${M:-default}
    do
        YN=$(eval echo \${MODELOADED_$mode:-no})
        if [ "$YN" != "yes" ]
        then
            . logging_$mode.sh
            if [ $? != 0 ]; then
                error_default "Cannot include logging_$mode.sh"        
            else
                eval MODELOADED_${mode}="yes"
            fi
        fi
        
        cmd=${func}_${mode}
        $cmd $*
        if [ $? != 0 ]; then
            error_default "Cannot call: ${func}_${mode}"
        fi
    done
}

##########################################################################
##
#   Global functions
#

##DOC error
# The error function used to report errors
#
# syntax: error <message>
#
error() {
    __do_it error $*
	return 0
}

warning() {
    if [ $TRACELEVEL = "warning" -o $TRACELEVEL = "info" -o $TRACELEVEL = "debug" ]; then
        __do_it warning $*
    fi
	return 0
}

info() {
    if [ $TRACELEVEL = "info" -o $TRACELEVEL = "debug" ]; then
        __do_it info $*
    fi
	return 0
}

infon() {
    if [ $TRACELEVEL = "info" -o $TRACELEVEL = "debug" ]; then
        __do_it infon $*
    fi
	return 0
}

debug() {
    if [ $TRACELEVEL = "debug" ]; then
        __do_it debug $*
    fi
	return 0
}

begin() {
    __do_it begin $*
}

end() {
    if [ "$#" -eq 0 ] || ([ -n "$1" ] && [ "$1" -eq 0 ])
	then
        __do_it end_ok $*
    else
        retval="$1"
		
        __do_it end_nok $*

		return ${retval}

    fi
    return 0
}

wend() {
    echo "NIY"
}

progress() {
    __do_it progress $*
}

##########################################################################
##
#   Setting globals
#

# error, warning, info or debug (error is always logged)
TRACELEVEL=${TRACELEVEL:-"error"} 

__help() {

    LOCATION=`type logging.sh`
    LOCATION=`echo $LOCATION | sed -e "s/logging.sh is hashed (//" | sed -e "s/)$//"`
    LOCATION=`echo $LOCATION | sed -e "s/logging.sh is //"`
    LOCATION=`dirname $LOCATION` 
    #echo $LOCATION
   
    MODES=default
    DUMMY=`ls $LOCATION/logging_*.sh 2>/dev/null`
    if [ $? = 0 ]; then
        for i in $LOCATION/logging_*.sh
        do
            #echo "i: $i"
            MM=`echo $i | sed -e "s!$LOCATION/logging_!!" | sed -e "s/.sh$//"`
            #echo "MM: $MM"
            MODES=$MODES:$MM
        done
    fi
    if [ $# -eq 0 ]; then
        
    echo "
-- MAIN HELP --
    
FUNCTIONS:
    trace statements:
        error
        warning
        info
        infon
        debug
        
    process statements:
        begin   - use before an action is executed, which consumes time
        end     - use to close and report ok/nok and optional reason

ENVIRONMENT VARS:
    TRACELEVEL
        values: error, warning, info or debug
        Example: 
          TRACELEVEL=info
            Only errors, warnins and info statements will be processed 
            (debug is ignored)
          TRACELEVEL=error
            Only errors will be processed (others are ignored)

    MODE ('default' if unset)
        Modes avialable:"
    
    echo -n "            "
    echo "`echo $MODES | sed -e "s/:/, /g"`"
    
    echo "
MORE HELP:
    Use logging.sh --help all   -or-   logging.sh --help <mode>
    
"
    else
        
        case "$1" in
        all)
            M=$MODE
            MODE=$MODES
            __do_it help
            MODE=$M
            ;;
        *)
            M=$MODE
            MODE=$1
            __do_it help
            MODE=$M
            ;;
        esac            
        
    fi
}

for arg in $*
do
    case "${arg}" in
        # Lastly check if the user disabled it with --nocolor argument
        --help)
            shift
            __help $*
            ;;
    esac
done



