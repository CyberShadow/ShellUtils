#!/bin/sh
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
    log 'error:' ${*}'.'
    exit 1
}


#---------------------------------------------------------------------
test "x${*}" = "x" && die 'no process given'

#LOG="`mktemp -p . -t gdb.XXXXXXXXXXX`"
#log "outputting trace to '${LOG}'"

GDB=gdb
#GDB=/home/wnbot/gdb/bin/gdb

stty -tostop
exec ${GDB} -batch \
    -ex 'handle SIG33 pass nostop noprint' \
    -ex 'set pagination 0' \
    -ex 'start' \
    -ex 'set no_catch_exceptions=1' \
    -ex 'continue' \
    -ex 'backtrace full' \
    -ex 'info registers' \
    -ex 'thread apply all backtrace' \
    -ex 'quit' \
    --args ${*} \
    < /dev/null

# 2>>"${LOG}"
#    -ex 'set logging on' \
#    -ex 'set logging overwrite on' \
#    -ex 'handle SIGTTOU nopass nostop noprint' \
#    -ex "set logging file ${LOG}" \
#    -ex 'run' \
