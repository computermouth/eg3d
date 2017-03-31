
all:
	gcc renderer.c -o main -std=c11 -lSDL2 -lSDL2_gfx -lm
