#!/usr/bin/make -f
# Makefile for DISTRHO Plugins #
# ---------------------------- #
# Created by falkTX
#

# --------------------------------------------------------------
# Project name, used for binaries

NAME = Super_Saw

# --------------------------------------------------------------
# Files to build

OBJS_DSP = \
	SuperSaw.cpp.o

#OBJS_UI  = \
#	InfoExampleUI.cpp.o

# --------------------------------------------------------------
# Do some magic

include ../Makefile.mk

# --------------------------------------------------------------
# Enable all possible plugin types

ifeq ($(HAVE_DGL),true)
ifeq ($(HAVE_JACK),true)
TARGETS += jack
endif
endif

ifeq ($(HAVE_DGL),true)
TARGETS += lv2_sep
else
TARGETS += lv2_dsp
endif

TARGETS += vst

ADA:
	gnat make -fPIC super_saw
	gnat make -fPIC b~super_saw
	gnat bind -n super_saw
	gnat bind -n b~super_saw

BASE_FLAGS +=  super_saw.o b~super_saw.o  -lgnat -lgnarl -lgmem
BASE_FLAGS += -L/usr/lib/gcc/x86_64-redhat-linux/6.3.1/adalib

all: ADA $(TARGETS)

# --------------------------------------------------------------
