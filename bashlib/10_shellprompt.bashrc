#---------------
# Shell Prompt
#---------------
NC='\e[0m'
if [[ "${DISPLAY#$HOST}" != ":0.0" &&  "${DISPLAY}" != ":0" ]]; then  
    HILIT='\e[0;31m'   # remote machine: prompt will be partly red
else
    HILIT='\e[0;36m'  # local machine: prompt will be partly cyan
fi
GREEN='\e[1;32m'
BLUE='\e[1;34m'

echo "Setting prompt for TERM $TERM"
#  --> Replace instances of \W with \w in prompt functions below
#+ --> to get display of full path name.

function gentooprompt()
{
    unset PROMPT_COMMAND
    case $TERM in
        *term* | rxvt | cygwin | msys )
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		PS1="${GREEN}\u@\h ${BLUE}\W \$ ${NC}"
		;;
        linux )
	        PS1="${HILIT}[\h]$NC \W > " ;;
	screen)
	        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
        *)
            PS1="[\h] \W > " ;;
    esac
}

function fastprompt()
{
    unset PROMPT_COMMAND
    case $TERM in
        *term* | rxvt | cygwin | msys )
            PS1="${HILIT}[\h]$NC \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
	    linux )
	        PS1="${HILIT}[\h]$NC \W > " ;;
        *)
            PS1="[\h] \W > " ;;
    esac
}

function powerprompt()
{
    _powerprompt()
    {
        LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
    }

    PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term* | rxvt | cygwin | msys )
            PS1="${HILIT}[\A \$LOAD]$NC\n[\h \#] \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\h \#] \w > " ;;
        * )
            PS1="[\A - \$LOAD]\n[\h \#] \w > " ;;
    esac
}

#fastprompt
#powerprompt
gentooprompt

# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:
