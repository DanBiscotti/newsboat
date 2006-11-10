CC=cc
CXX=c++
CFLAGS=-g -I./include -I./stfl
CXXFLAGS=-g -I./include -I./stfl
LDFLAGS=-g
LIBS=-lstfl -lmrss -lnxml -lncurses
OUTPUT=noos
SRC=$(wildcard *.cpp) $(wildcard src/*.cpp)
OBJS=$(patsubst %.cpp,%.o,$(SRC))

STFLHDRS=$(patsubst %.stfl,%.h,$(wildcard stfl/*.stfl))

STFLCONV=./stfl2h.pl
RM=rm -f

all: $(OUTPUT)

$(OUTPUT): $(STFLHDRS) $(OBJS)
	$(CXX) $(LDFLAGS) $(CXXFLAGS) -o $(OUTPUT) $(OBJS) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

%.h: %.stfl
	$(STFLCONV) $< > $@

clean:
	$(RM) $(OUTPUT) $(OBJS) $(STFLHDRS) core *.core Makefile.deps

Makefile.deps: $(SRC)
	$(CXX) -MM -MG $(SRC) > Makefile.deps

include Makefile.deps
