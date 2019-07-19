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

begin "Setting prompt for TERM $TERM"
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

function debianprompt()
{
  unset PROMPT_COMMAND
  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  	# We have color support; assume it's compliant with Ecma-48
  	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  	# a case would tend to support setf rather than setaf.)
  	color_prompt=yes
      else
  	color_prompt=
      fi
  fi

  if [ "$color_prompt" = yes ]; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
  *)
      ;;
  esac

}

function gitprompt()
{
  # Set config variables first
   export GIT_PROMPT_ONLY_IN_REPO=1

   # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

   export GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
   # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

   # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

   GIT_PROMPT_START="\u@\h"    # uncomment for custom prompt start sequence
   GIT_PROMPT_END="\n\w $ "      # uncomment for custom prompt end sequence

   # as last entry source the gitprompt script
   # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
   export GIT_PROMPT_THEME=Solarized_Ubuntu # use theme optimized for solarized color scheme
   source ~/.bash-git-prompt/gitprompt.sh
}

function powerlineprompt()
{
  powerline-daemon -q
  export POWERLINE_BASH_CONTINUATION=1
  export POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
}

#fastprompt
#powerprompt
#gentooprompt
#debianprompt
powerlineprompt

if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
  gitprompt
fi

end

# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:
