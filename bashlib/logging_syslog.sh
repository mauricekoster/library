__syslog() {
	local pri=
	local tag=
    local facility=
    
    if [ "$FACILITY" = "" ]; then
        facility="user"
    else
        facility=$FACILITY
    fi

    pri=$1
    tag=$2
    shift 2

    [ "$*" = "" ] && return 0


    if [ -x /usr/bin/logger ]
    then
        /usr/bin/logger -p "${facility}.${pri}" -t "${tag}" -- "$*"
    fi

    if [ -x /opt/bin/logger ]
    then
        /opt/bin/logger -p ${facility}.${pri} -t "${tag}" -- "$*"
    fi

    return 0
}

error_syslog() {
    __syslog "error" $TAG $*
}
warning_syslog() {
    __syslog "warning" $TAG $*
}

info_syslog() {
    __syslog "info" $TAG $*
}
infon_syslog() {
    __syslog "info" $TAG $*
}
debug_syslog() {
    __syslog "debug" $TAG $*
}

begin_syslog() {
    __syslog "info" $TAG "-- START -- $*... "
}

end_ok_syslog() {
    __syslog "info" $TAG "-- EINDE -- [ok]"
}

end_nok_syslog() {
    
	if [ "$#" -ge 2 ]
	then
        local errno=$1
		shift
		error_syslog "-- ($errno) -- ${*} "
	fi
    __syslog "info" $TAG "-- EINDE -- [!!]"    
}

FACILITY=${FACILITY:-user}
TAG=${TAG:-$0}
