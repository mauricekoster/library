_file_logger() {
    LEVEL=$1
    shift
    
    tag=${TAG:-$0}
    
    DATE=`date +"%b %d %H:%M:%S"`
    
    FILENAME=${FILENAME:-user}
    LOG_DIR=${LOG_DIR:-$HOME}
    LOG=${LOG:-$FILENAME.log}
    HOSTNAME=`hostname`
    
    echo "$DATE $HOSTNAME [$LEVEL] $tag: $*" >>"$LOG_DIR/$LOG"

}

error_file() {
    _file_logger "error"  $*
}

warning_file() {
    _file_logger "warning"  $*
}

info_file() {
    _file_logger "info"  $*
}

infon_file() {
    _file_logger "info"  $*
}

debug_file() {
    _file_logger "debug"  $*
}

begin_file() {
    _file_logger "info"  "-- START -- $*... "
}

end_ok_file() {
    _file_logger "info"  "-- EINDE -- [ok]"
}

end_nok_file() {
    
	if [ "$#" -ge 2 ]
	then
        local errno=$1
		shift
		error "-- ($errno) -- ${*} "
	fi
    _file_logger "info"  "-- EINDE -- [!!]"    
}


