handle SIG33 pass nostop noprint
handle SIGTERM pass nostop noprint
handle SIGINT pass nostop noprint
handle SIGUSR1 pass nostop noprint
handle SIGUSR2 pass nostop noprint
handle SIGPIPE pass nostop noprint
set pagination 0

#start # breaks on D main in newer gdb versions, after runtime initialization, which is too late to set rt_trapExceptions
break main
run

# 2.069 and older:
#break rt.deh_win64_posix.terminate()
# 2.070 and newer:
break abort

commands
silent
echo === backtrace: ===\n
backtrace
echo === end of backtrace ===\n

call (void)dup2(1, 2)
echo === _d_print_throwable: ===\n
#call (void)fprintf(stdout, "e: %.*s\n", *(**(size_t***)h+4), *(**(char****)h+5))
#call (void)fprintf(stdout, "file: %.*s\n", *((size_t*)h+4), *((char**)h+5))
#call (void)fprintf(stdout, "line: %zd\n", *((size_t*)h+6))
#call (void)fprintf(stdout, "msg: %.*s\n", *((size_t*)h+2), *((char**)h+3))
#call (void)fprintf(stdout, "=========================================\n")
#call (void)fflush(stdout)
#call _D2rt6dmain214printThrowableFC6object9ThrowableZv(h)
#frame 1
#call _d_print_throwable(h)
select-frame 1
#call _d_print_throwable(o)
set language c
call (void)_d_print_throwable(*(void**)($rbp-8))
echo === end of _d_print_throwable ===\n
call (void)fflush(stderr)
continue
end

set *(int*)&rt_trapExceptions=0
continue
info registers
thread apply all backtrace
quit
