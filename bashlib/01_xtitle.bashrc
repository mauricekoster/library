function xtitle ()
{
    case "$TERM" in
        *term | rxvt | cygwin | msys)
            echo -n -e "\033]0;$*\007" ;;
        *) 
	    ;;
    esac
}
declare +x xtitle
