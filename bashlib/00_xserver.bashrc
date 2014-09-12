#-------------------------------------------------------------
# Automatic setting of $DISPLAY (if not set already)
# This works for linux - your mileage may vary.... 
# The problem is that different types of terminals give
# different answers to 'who am i'......
# I have not found a 'universal' method yet
#-------------------------------------------------------------

function get_xserver ()
{
    if [ "`which who`" = "" ]; then
        XSERVER=""
        return
    fi
    case $TERM in
	xterm* | cygwin | msys )
	    XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' ) 
	    XSERVER=${XSERVER%%:*}
	    ;;
	aterm | rxvt)
 	# find some code that works here.....
	    ;;
    esac  
}

if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then 
	DISPLAY=":0.0"		# Display on local host
    else		
	DISPLAY=${XSERVER}:0.0	# Display on remote host
    fi
fi

export DISPLAY
