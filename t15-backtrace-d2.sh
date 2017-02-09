#!/bin/bash
#---------------------------------------------------------------------
usage() {
    cat<<EOF
Usage: ${0} program_name [program_args]

Trace a given program using gdb.

EOF
}

log() {
    echo "${*}" 1>&2
}

die() {
    usage
    log 'error:' "${*}"'.'
    exit 1
}


#---------------------------------------------------------------------
test "x${*}" = "x" && die 'no process given'

#LOG="`mktemp -p . -t gdb.XXXXXXXXXXX`"
#log "outputting trace to '${LOG}'"

GDB=gdb
#GDB=/home/wnbot/gdb/bin/gdb

stty -tostop
${GDB} -batch \
    --command "$(dirname "$0")"/t15-backtrace-d2.gdb \
    --args "$@" \
    < /dev/null \
    | dtools-ddemangle

# 2>>"${LOG}"
#    -ex 'backtrace full' \
#    -ex 'set logging on' \
#    -ex 'set logging overwrite on' \
#    -ex 'handle SIGTTOU nopass nostop noprint' \
#    -ex "set logging file ${LOG}" \
#    -ex 'run' \
#    --command <(echo aoeu) \
