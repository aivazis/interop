# -*- Makefile -*-

CC = gcc
CXX = g++
F95 = gfortran

compile.f95 = $(F95) -c
compile.c++ = $(CXX) -std=c++14 -c

sources := image

library := libimage.a
objects := $(addsuffix .o, $(sources))
modules := $(addsuffix _module.mod, $(sources))
tests   := test_cc test_f95


all: tests

tests: $(tests)

test_cc: main.cc $(library) $(modules)
	$(CXX) -std=c++14 main.cc -o $@ -L. -limage -lgfortran

test_f95: main.f95 $(library) $(modules)
	$(F95) main.f95 -o $@ -L. -limage

%.o %_module.mod : %.f95
	$(compile.f95) $<

libimage.a: image.o
	ar ruv $@ $<

clean:
	rm -f *~ $(tests) $(library) $(modules) $(objects)

# end of file
