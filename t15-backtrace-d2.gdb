set args -s 2>&1
handle SIG33 pass nostop noprint
handle SIGTERM pass nostop noprint
handle SIGINT pass nostop noprint
handle SIGUSR1 pass nostop noprint
handle SIGUSR2 pass nostop noprint
set pagination 0
start
break rt.deh_win64_posix.terminate()
commands
silent
backtrace
frame 1
#call (void)fprintf(stdout, "e: %.*s\n", *(**(size_t***)h+4), *(**(char****)h+5))
#call (void)fprintf(stdout, "file: %.*s\n", *((size_t*)h+4), *((char**)h+5))
#call (void)fprintf(stdout, "line: %zd\n", *((size_t*)h+6))
#call (void)fprintf(stdout, "msg: %.*s\n", *((size_t*)h+2), *((char**)h+3))
#call (void)fprintf(stdout, "=========================================\n")
#call (void)fflush(stdout)
call _D2rt6dmain214printThrowableFC6object9ThrowableZv(h)
call (void)fflush(stderr)
continue
end
set rt_trapExceptions=0
continue
info registers
thread apply all backtrace
quit
