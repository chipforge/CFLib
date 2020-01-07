#   ************    CFLib   *******************************************
#
#   Organisation:   Chipforge
#                   Germany / European Union
#
#   Profile:        Chipforge focus on fine System-on-Chip Cores in
#                   Verilog HDL Code which are easy understandable and
#                   adjustable. For further information see
#                           www.chipforge.org
#                   there are projects from small cores up to PCBs, too.
#
#   File:           CFLib/GNUmakefile
#
#   Purpose:        Global Makefile
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2019, 2020 by
#                   chipforge <cflib@nospam.chipforge.org>
#
#       This Source Code Library is licensed under the Libre Silicon
#       public license; you can redistribute it and/or modify it under
#       the terms of the Libre Silicon public license as published by
#       the Libre Silicon alliance, either version 1 of the License, or
#       (at your option) any later version.
#
#       This design is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#       See the Libre Silicon Public License for more details.
#
#   ////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#                   DEFINITIONS
#   ----------------------------------------------------------------

#       directory names

RTL ?=                  RTL
TBENCH ?=               TBench
SVA ?=                  SVA

#       tool variables

# self-compiled version
TOOLPATH ?=             /usr/local/bin
# distribution specific version
#TOOLPATH ?=            /usr/bin
SIMULATOR1 ?=           $(TOOLPATH)/iverilog -g2012 -Wall
SIMULATOR2 ?=           $(TOOLPATH)/vvp # -v
WAVEVIEWER ?=           gtkwave

RM ?=                   /bin/rm -f

#       other stuff

DUMPPATH ?=             $(TBENCH)
COMPONENTS =            asyncrst

#   ----------------------------------------------------------------
#                       DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	#    -------------------------------------------------------------
	#    available targets:
	#    -------------------------------------------------------------
	#
	#    help       - print this help screen
	#    clean      - clean up all intermediate files
	#    all        - simulate/verify/check all components
	#
	#    -------------------------------------------------------------
	#    library components:
	#    -------------------------------------------------------------
	#
	#    $(COMPONENTS)
	#

.PHONY: clean
clean:
	-$(RM) *.vpp */$(DUMPPATH)/*.vcd

.PHONY: all
all: $(COMPONENTS)

#   ----------------------------------------------------------------
#                       TESTCASES
#   ----------------------------------------------------------------

asyncrst:  ADDITIONALS += -DDUMPFILE=\"$@/$(DUMPPATH)/$@.vcd\"
asyncrst:  asyncrst/$(RTL)/asyncrst.sv asyncrst/$(TBENCH)/tb_asyncrst.sv
	$(SIMULATOR1) $(ADDITIONALS) -o $@.vpp $<
	#   ----    Run Test: $@    ----
	$(SIMULATOR2) $@.vpp
ifeq ($(MODE), gui)
	$(WAVEVIEWER) -f $@/$(DUMPPATH)/$@.vcd -a $@/$(DUMPPATH)/tb_$@.do
endif

##        ;;       .;;;. ;; ;; ;; ;;;;. ;;;; ;;;. ;;;;. .;;;. ;;;;
##        ;;;;;;   ;; ;; ;; ;; ;; ;; ;; ;;  ;; ;; ;; ;; ;; ;; ;;
##     ;, ;;       ;;    ;;;;; ;; ;; ;; ;;; ;; ;; ;;;;' ;;,,, ;;;
##  ;;;;;;;;;;;;   ;; ;; ;; ;; ;; ;;;;' ;;  ;; ;; ;;';; ;; ;; ;;
##     :' ;;       ';;;' ;; ;; ;; ;;    ;;  ';;;' ;; ;; ';;;; ;;;;

