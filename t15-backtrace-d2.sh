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
${GDB} -batch \
    --command /usr/local/bin/t15-backtrace-d2.gdb \
    --args ${*} \
    < /dev/null \
    | /usr/local/bin/ddemangle

# 2>>"${LOG}"
#    -ex 'backtrace full' \
#    -ex 'set logging on' \
#    -ex 'set logging overwrite on' \
#    -ex 'handle SIGTTOU nopass nostop noprint' \
#    -ex "set logging file ${LOG}" \
#    -ex 'run' \
#    --command <(echo aoeu) \


exit

#    -ex 'handle SIG33 pass nostop noprint' \
    -ex 'handle SIGTERM pass nostop noprint' \
    -ex 'handle SIGINT pass nostop noprint' \
    -ex 'handle SIGUSR1 pass nostop noprint' \
    -ex 'handle SIGUSR2 pass nostop noprint' \
    -ex 'set pagination 0' \
    -ex 'start' \
    -ex 'echo \n\n\ntest\n\n\n' \
    -ex 'break rt.deh_win64_posix.terminate()' \
    -ex 'commands' \
    "\n" 'silent' \
    "\n" 'echo \n\n\nhit\n\n\n' \
    "\n" 'where' \
     'info registers' \
     'frame 1' \
     'call printf("e: %.*s\n", *(**(size_t***)h+4), *(**(char****)h+5))' \
     'call printf("file: %.*s\n", *((size_t*)h+4), *((char**)h+5))' \
     'call printf("line: %zd\n", *((size_t*)h+6))' \
     'call printf("msg: %.*s\n", *((size_t*)h+2), *((char**)h+3))' \
     'continue' \
     'end' \
    -ex 'set rt_trapExceptions=0' \
    -ex 'continue' \
    -ex 'info registers' \
    -ex 'thread apply all backtrace' \
    -ex 'quit' \




echo <<EOF
handle SIG33 pass nostop noprint
handle SIGTERM pass nostop noprint
handle SIGINT pass nostop noprint
handle SIGUSR1 pass nostop noprint
handle SIGUSR2 pass nostop noprint
set pagination 0
start
echo \n\n\ntest\n\n\n
break rt.deh_win64_posix.terminate()
commands
silent
echo \n\n\nhit\n\n\n
where
info registers
frame 1
call printf("e: %.*s\n", *(**(size_t***)h+4), *(**(char****)h+5))
call printf("file: %.*s\n", *((size_t*)h+4), *((char**)h+5))
call printf("line: %zd\n", *((size_t*)h+6))
call printf("msg: %.*s\n", *((size_t*)h+2), *((char**)h+3))
continue
end
set rt_trapExceptions=0
continue
info registers
thread apply all backtrace
quit
EOF
