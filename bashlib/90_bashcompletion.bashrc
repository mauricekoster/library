#=========================================================================
#
# PROGRAMMABLE COMPLETION - ONLY SINCE BASH-2.04
# Most are taken from the bash 2.05 documentation and from Ian McDonalds
# 'Bash completion' package (http://www.caliban.org/bash/index.shtml#completion)
# You will in fact need bash-2.05a for some features
#
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "2.05" ]; then
    echo "You will need to upgrade to version 2.05 for programmable completion"
    return
fi

if [ -f $HOME/.bash_completion ]; then
    source $HOME/.bash_completion
elif [ -f /opt/etc/bash_completion ]; then
    source /opt/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
else
    echo "No bashcompletion found."
fi
	
# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:
