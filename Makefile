PROGRAMS=\
	n \
	t15-backtrace-d2.gdb \
	t15-backtrace-d2.sh \
	t15-backtrace.sh \
	t15-d2-runcheck \
	verynice

install:
	cp $(PROGRAMS) /usr/local/bin/
