
all:
	gcc render.c -o main -Wall -std=c11 -lSDL2 -lSDL2_gfx -lm
