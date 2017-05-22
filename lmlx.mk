LIBMLX= $(DLIBMLX)/libmlx.a
LMLX= -L $(DLIBMLX) -lmlx
OS := $(shell uname -s)
ifeq ($(OS),Darwin)
	LMLX += -framework OpenGL -framework AppKit
else
	LMLX += -lXext -lX11
endif

