handle SIG33 pass nostop noprint
handle SIGTERM pass nostop noprint
handle SIGINT pass nostop noprint
handle SIGUSR1 pass nostop noprint
handle SIGUSR2 pass nostop noprint
set pagination 0
start
#echo \n\n\ntest\n\n\n
break rt.deh_win64_posix.terminate()
commands
silent
#echo \n\n\nhit\n\n\n
#where
#info registers
frame 1
call (void)fprintf(stderr, "e: %.*s\n", *(**(size_t***)h+4), *(**(char****)h+5))
call (void)fprintf(stderr, "file: %.*s\n", *((size_t*)h+4), *((char**)h+5))
call (void)fprintf(stderr, "line: %zd\n", *((size_t*)h+6))
call (void)fprintf(stderr, "msg: %.*s\n", *((size_t*)h+2), *((char**)h+3))
continue
end
set rt_trapExceptions=0
continue
info registers
thread apply all backtrace
quit
