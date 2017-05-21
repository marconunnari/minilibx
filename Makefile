NOM=libmlx.a

DIR=
OS := $(shell uname -s)
REL := $(shell uname -r | cut -c1-2)
ifeq ($(OS),Darwin)
	ifeq ($(REL),16)
		DIR=sierra
	else
		DIR=elcapitain
	endif
else
	DIR=x11
endif

all: $(NOM)

$(NOM):
	@echo "version:" $(DIR)
	make -C $(DIR)
	cp $(DIR)/$(NOM) .
	cp $(DIR)/mlx.h .

clean:
	make clean -C $(DIR)
	rm -f $(NOM)

re: clean all
