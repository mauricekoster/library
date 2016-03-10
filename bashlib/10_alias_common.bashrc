#-------------------
# Personnal Aliases
#-------------------
begin "Common aliases"
#aLias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias r='rlogin'
#alias which='type -all'
alias ..='cd ..'
alias ...='cd ../..'

alias path='echo -e ${PATH//:/\\n}'
alias ldpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias background='xv -root -quit -max -rmode 5'    # Put a picture in the background
alias du='du -kh'
alias df='df -kTh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


end
