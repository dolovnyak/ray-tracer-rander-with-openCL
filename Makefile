NAME = ray_trace

FLAGS = -c -O3

MLXFLAGS = -lmlx -framework OpenGL -framework OpenCL -framework AppKit -O3

SOURCES = initialization.c \
		  scene_mario_eden.c \
		  scene_too_many_problems.c \
		  initialization_cl.c \
		  utilits_for_initialization_cl.c \
		  main.c \
		  create_objects.c \
		  create_lights.c \
		  keyboard_events.c \
		  mouse_events.c \
		  scene_s.c \
		  scene_s2.c

UTILITS = color.c \
		  math_vec1.c \
		  math_vec2.c

INCLUDES = $(addprefix -I, ./includes)

LIB = libft/libft.a

DIR_O = objs

DIR_S = srcs

DIR_U = utilits

SRCS = $(addprefix $(DIR_S)/,$(SOURCES))

OBJS = $(addprefix $(DIR_O)/,$(SOURCES:.c=.o))

UTLS = $(addprefix $(DIR_O)/,$(UTILITS:.c=.o))

all: $(LIB) $(NAME)

$(LIB):
			@echo "\x1b[35;01mCompilation Lib and binary\x1b[32;01m"
			@make -C ./libft

$(NAME):	$(OBJS) $(UTLS)
			gcc -I /usr/local/include $(OBJS) $(UTLS) $(LIB) -L /usr/local/lib/ $(MLXFLAGS) -o $(NAME)

$(OBJS):	$(DIR_O)/%.o: $(DIR_S)/%.c includes/config.h
			@mkdir -p $(DIR_O)
			gcc $(FLAGS) $(INCLUDES) -o $@ $<

$(UTLS):	$(DIR_O)/%.o: $(DIR_U)/%.c includes/config.h
			@mkdir -p $(DIR_O)
			gcc $(FLAGS) $(INCLUDES) -o $@ $<

clean:
			@echo "\x1b[36;01mDeliting .o files\x1b[31;01m"
			@/bin/rm -rf $(DIR_O)
			@make clean --directory ./libft

fclean: clean
			@echo "\x1b[36;01mDeliting execute file\x1b[31;01m"
			@/bin/rm -f $(NAME)
			@make fclean --directory ./libft

re: fclean all
