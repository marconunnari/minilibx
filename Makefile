NAME=libmlx.a

GCC= gcc -Wall -Wextra -Werror

INCLUDES= -I includes -I $(DLIBFT)/includes
HEADER= includes/mlx.h

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

DOBJS= objs
DSRCS= srcs

SRCS_FILES= fill_pixel fill_rect fill_square ft_swap_ints

SRCS = $(addprefix $(DSRCS)/, $(addsuffix .c, $(SRCS_FILES)))
OBJS = $(SRCS:$(DSRCS)/%.c=$(DOBJS)/%.o)

all: $(NAME)

$(DOBJS):
	mkdir -p $(DOBJS)

$(OBJS): $(DOBJS)/%.o: $(DSRCS)/%.c $(HEADER)
	$(GCC) $(INCLUDES) -c $< -o $@

start:
	echo "making minilibx..."

$(NAME): start $(DOBJS) $(OBJS) $(HEADER)
	echo "version:" $(DIR)
	make -C $(DIR)
	cp $(DIR)/$(NAME) $(DOBJS)/$(NAME)
	ar -x $(DOBJS)/$(NAME)
	mv mlx_*.o $(DOBJS)
	rm -f $(DOBJS)/$(NAME)
	ar rcs $(NAME) $(DOBJS)/*.o
	echo "minilibx done!"

clean:
	@make clean -C $(DIR)
	@rm -rf $(DOBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all
