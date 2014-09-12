# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -Al'               # show hidden files

# add colors for filetype recognition
( ls --color 2>/dev/null >/dev/null )
if [ $? -eq 0 ]; then
    alias ls='ls -hF --color'
else 
    alias ls='ls -hF'
fi

alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time  
alias lu='ls -lur'		# sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'

( tree 2>/dev/null >/dev/null )
if [ $? -eq 0 ]; then 
    alias tree='tree -Csu'		# nice alternative to 'ls'
fi
