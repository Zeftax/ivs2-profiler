###################################################
# Project name: ivs2-profiler
# Date:         2023-04-23
# File:         Makefile
#
# Author: Zdeněk Borovec <xborov08@vutbr.cz>
# Author: Tomáš Krejčí   <xkrejc84@vutbr.cz>
# Author: Jan Lozrt      <xlozrt00@vutbr.cz>
# Author: Jakub Mitrenga <xmitre07@vutbr.cz>
#
# Description: Profiler for testing the performance of our ivs2-mathlib math library
#
###################################################

ROOTDIR    = .
BUILDDIR   = _build
MATHDIR    = ../ivs2-mathlib
TSTDIR     = tst

# make sure to use the go version of pprof!
# https://github.com/google/pprof
PPROF      = ~/go/bin/pprof

EXEC       = stddev


# == INSTALLATION TARGETS ==
.PHONY: all test run profile mathlib

# compiles the project
all: profile

# runs profiler tests
test: profile
	cd $(ROOTDIR)/$(BUILDDIR) && make test

# runs the program
run: 
	@if [ -f $(ROOTDIR)/$(BUILDDIR)/$(EXEC) ]; then\
		$(ROOTDIR)/$(BUILDDIR)/$(EXEC);\
	else\
		echo "You must run 'make' or 'make profile' first";\
	fi\

# installs the profiler
profile: mathlib
	mkdir -p $(ROOTDIR)/$(BUILDDIR) && cd $(ROOTDIR)/$(BUILDDIR) &&\
		cmake .. && cmake --build . --target install

# installs ivs2-mathlib
mathlib:
	mkdir -p $(MATHDIR)/$(BUILDDIR) && cd $(MATHDIR)/$(BUILDDIR) &&\
		cmake .. && cmake --build . --target install

# profiles the program ("evaluates" performance)
eval: profile
	# 10 samples
	export LD_PRELOAD=/usr/lib/libprofiler.so && \
			   export CPUPROFILE=$(ROOTDIR)/$(BUILDDIR)/prof10.out  &&\
			   $(BUILDDIR)/$(EXEC) < $(TSTDIR)/data10.txt
	# 1k samples
	export LD_PRELOAD=/usr/lib/libprofiler.so &&\
			   export CPUPROFILE=$(ROOTDIR)/$(BUILDDIR)/prof1k.out &&\
			   $(BUILDDIR)/$(EXEC) < $(TSTDIR)/data1k.txt
	# 1m samples
	export LD_PRELOAD=/usr/lib/libprofiler.so \
			   export CPUPROFILE=$(ROOTDIR)/$(BUILDDIR)/prof1m.out &&\
			   $(BUILDDIR)/$(EXEC) < $(TSTDIR)/data1m.txt
	# generate report
	$(PPROF) -ignore="read_input" -png $(BUILDDIR)/$(EXEC) \
		$(BUILDDIR)/prof1m.out \
		$(BUILDDIR)/prof1k.out \
		$(BUILDDIR)/prof10.out > $(BUILDDIR)/report.png


# == CLEAN TARGETS == 
.PHONY: clean mathlib-clean profile-clean

# removes all built files
clean: mathlib-clean profile-clean
	rm -f $(ROOTDIR)/doxygen_warning.txt
	rm -f $(ROOTDIR)/compile_commands.json

# removes compiled ivs2-mathlib files
mathlib-clean:
	rm -R -f $(MATHDIR)/$(BUILDDIR)
	rm -R -f $(MATHDIR)/install

# removes compiled ivs2-profiler files
profile-clean:
	rm -R -f $(ROOTDIR)/$(BUILDDIR)
	rm -R -f $(ROOTDIR)/install


# == OTHER TARGETS ==
.PHONY: ccmds deb-prof

# generates compile_commands.json for autocomplete in neovim
ccmds:
	mkdir -p $(ROOTDIR)/$(BUILDDIR) && cd $(ROOTDIR)/$(BUILDDIR) &&\
		cmake .. && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
	cp $(ROOTDIR)/$(BUILDDIR)/compile_commands.json $(ROOTDIR)/

deb-prof: profile
	cd $(ROOTDIR)/$(BUILDDIR) \
		&& cpack -G DEB \
		|| echo "Something went wrong. Try running 'make clean' first"
