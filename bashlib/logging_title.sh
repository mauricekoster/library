error_title() {
    return 0
}

warning_title() {
    return 0
}

info_title() {
    return 0
}

infon_title() {
    return 0
}

debug_title() {
    return 0
}


__title ()
{
    case "$TERM" in
        xterm | xterm-color | rxvt | cygwin)
            echo -n -e "\033]0;$*\007" ;;
        *)  
	    ;;
    esac
}
begin_title() {
    __title $*
}

end_ok_title() {
    __title ""
}

end_nok_title() {
    __title ""
}

help_title() {
    echo "
MODE title

Use this mode to disable all logging. 
All trace functions will return directly.
Except: begin and end.
begin will put message in titlebar of window.
end will remove it.
"
}
