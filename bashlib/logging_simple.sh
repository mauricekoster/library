error_simple() {
    echo " ! ${*}"
}

warning_simple() {
    echo " # ${*}"
}

info_simple() {
    echo " * ${*}"
}

infon_simple() {
    echo -n " * ${*}"
}

debug_simple() {
    echo " + ${*}"
}

begin_simple() {
    echo -n ">>> $*... "
}

end_ok_simple() {
    echo "<< [ok]"
}

end_nok_simple() {
    echo "<<< [!!]"
    
	if [ "$#" -ge 2 ]
	then
        local errno=$1
		shift
		error "${*} ($errno)"
	fi
    
    echo
}

progress_simple()
{
    P=$1

    MSG=${MSG:-"Progress"}
    
    echo -ne "\r @ ${MSG:0:50} (${P}%)"
    
    if [ $P -ge 100 ]
    then
        echo -ne "\r${SPACES}"
        echo -e "\r @ ${MSG:0:50} : Done"
    fi
}

