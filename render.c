#include <stdio.h>
#include <math.h>
#include <time.h>

#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>

unsigned char quit = 0;
unsigned int cur_frame = 0;
float light1_x = .1;
float light1_y = .35;
float light1_z = .2;
void (*scene_update_func)();
void (*scene_background_func)();
int k_colorize_static = 1;
int k_colorize_dynamic = 2;
int k_multi_color_static = 3;
int k_multi_color_dynamic = 4;
int k_preset_color = 5;

//~ unsigned char column_v_string[] = { 
	//~ 0xfe, 0x00, 0xff, 0xfd, 0x02, 0x00, 0xfe, 0x00, 0xff, 0xfd, 0xfe, 
	//~ 0x00, 0x02, 0x00, 0xff, 0xfd, 0xfe, 0x00, 0x02, 0x00, 0xff, 0xfd, 
	//~ 0x02, 0x00, 0xfe, 0x00, 0x01, 0x14, 0x02, 0x00, 0xfe, 0x00, 0x01, 
	//~ 0x14, 0xfe, 0x00, 0x02, 0x00, 0x01, 0x14, 0xfe, 0x00, 0x02, 0x00, 
	//~ 0x01, 0x14, 0x02, 0x00, 0xfe, 0xf5, 0x02, 0x9c, 0x01, 0x0a, 0xfe, 
	//~ 0xf5, 0x02, 0x9c, 0xfe, 0xf5, 0x01, 0x0a, 0x02, 0x9c, 0xfe, 0xf5, 
	//~ 0x01, 0x0a, 0x02, 0x9c, 0x01, 0x0a, 0x00, 0x00, 0x10, 0x3c, 0x01, 
	//~ 0x79, 0xfe, 0x86, 0x10, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x10, 0x3c, 
	//~ 0xfe, 0x86, 0x01, 0x79, 0x10, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x11, 
	//~ 0x58, 0x02, 0x89, 0xfd, 0x76, 0x11, 0x58, 0x00, 0x00, 0x00, 0x00, 
	//~ 0x11, 0x58, 0xfd, 0x76, 0x02, 0x89, 0x11, 0x58, 0x00, 0x00 
	//~ };

float column_v_string [120] = {
	-2.000000, -1.011719, 2.000000, -2.000000, -1.011719, -2.000000, 
	2.000000, -1.011719, -2.000000, 2.000000, -1.011719, 2.000000, 
	-2.000000, 1.078125, 2.000000, -2.000000, 1.078125, -2.000000, 
	2.000000, 1.078125, -2.000000, 2.000000, 1.078125, 2.000000, 
	-2.042969, 1.609375, 1.039062, -2.042969, 1.609375, -2.042969, 
	1.039062, 1.609375, -2.042969, 1.039062, 1.609375, 1.039062, 
	0.000000, 16.234375, 1.472656, -2.476562, 16.234375, 0.000000, 
	0.000000, 16.234375, -2.476562, 1.472656, 16.234375, 0.000000, 
	0.000000, 17.343750, 1.535156, -2.539062, 17.343750, 0.000000, 
	0.000000, 17.343750, -2.539062, 1.535156, 17.343750, 0.000000
};


char column_f_string[] = { 
	0x06, 0x02, 0x01, 0x07, 0x03, 0x02, 0x08, 0x04, 0x03, 0x05, 0x01, 
	0x04, 0x05, 0x08, 0x0c, 0x10, 0x0d, 0x0c, 0x08, 0x07, 0x0b, 0x07, 
	0x06, 0x0a, 0x06, 0x05, 0x09, 0x10, 0x14, 0x11, 0x0f, 0x10, 0x0b, 
	0x0e, 0x0f, 0x0a, 0x0d, 0x0e, 0x09, 0x0f, 0x13, 0x14, 0x0e, 0x12, 
	0x13, 0x0d, 0x11, 0x12, 0x0d, 0x09, 0x0c, 0x10, 0x0c, 0x0b, 0x0f, 
	0x0b, 0x0a, 0x0e, 0x0a, 0x09, 0x05, 0x06, 0x01, 0x06, 0x07, 0x02, 
	0x07, 0x08, 0x03, 0x08, 0x05, 0x04, 0x09, 0x05, 0x0c, 0x0c, 0x08, 
	0x0b, 0x0b, 0x07, 0x0a, 0x0a, 0x06, 0x09, 0x0d, 0x10, 0x11, 0x10, 
	0x0f, 0x14, 0x0f, 0x0e, 0x13, 0x0e, 0x0d, 0x12
};

typedef struct {
	float min_x;
	float min_y;
	float min_z;
	float max_x;
	float max_y;
	float max_z;
	float x;
	float y;
	float z;
	float vx;
	float vy;
	float vz;
} player_t;
player_t player;

typedef struct {
	void *fake;
} obstacle_list_t;

typedef struct {
	void *fake;
} particle_list_t;

typedef struct {
	unsigned short x;
	unsigned short y;
} star_t;
star_t star_list[150];

typedef struct {
	float * vertices;
	char * base_faces;
	char ** faces;
	float ** t_vertices;
	int x;
	int y;
	int z;
	int rx;
	int ry;
	int rz;
	int tx;
	int ty;
	int tz;
	int ax;
	int ay;
	int az;
	int sx;
	int sy;
	int radius;
	int sradius;
	int visible;
	int render;
	int background;
	int collision_x;
	int collision_y;
	int collision_down;
	int collision_up;
	int collision_left;
	int ring;
	int min_x;
	int min_y;
	int min_z;
	int max_x;
	int max_y;
	int max_z;
	int vx;
	int vy;
	int vz;
	int age;
	int health;
} object_t;

object_t * object_list = NULL;
int object_list_used = 0;
int object_list_length = 0;

void init_player(){
	player.min_x = -4.5;
	player.min_y = -4.5;
	player.min_z = -4.5;
	player.max_x = 4.5;
	player.max_y = 4.5;
	player.max_z = 4.5;
	player.x = 0;
	player.y = 8;
	player.z = 15;
	player.vx = 0;
	player.vy = 0;
	player.vz = 0;
}

void normalize(float * norm_x, float * norm_y, float * norm_z){
	*norm_x *= 4;
	*norm_y *= 4;
	*norm_z *= 4;
	
	float inv_dist=1/sqrt((*norm_x) * (*norm_x)
		+ (*norm_y) * (*norm_y)
		+ (*norm_z) * (*norm_z));
	
	*norm_x *= inv_dist;
	*norm_y *= inv_dist;
	*norm_z *= inv_dist;
}

void init_light(){
	normalize(&light1_x, &light1_y, &light1_z);
}

void init_3d(){
	
	init_player();
	init_light();
	
	if (object_list != NULL){ /*free it all*/ };
	object_list = NULL;
	
	obstacle_list_t obs_l = { .fake = NULL };
	particle_list_t p_l = { .fake = NULL };
	
}

void load_scene(void (*init_func)(), void (*update_func)(), void (*background_func)()){
	scene_update_func = update_func;
	scene_background_func = background_func;
	init_func();
}

void init_stars(){
	for(int i = 0; i < 150; i++){
		star_list[i].x = rand() % 508;
		star_list[i].y = rand() % 55;
	}
}

void add_object_to_list(object_t new_obj){
	
	if (object_list_used == object_list_length){
		object_list_length += 2;
		object_list = realloc(object_list, (sizeof(* object_list)) * object_list_length);
	}
	
	object_list[object_list_used] = new_obj;
	
	object_list_used++;
}

void del_object_from_list(int i){
	object_list[i] = object_list[object_list_used -1];
	object_list_used--;
}

object_t new_object(){
	object_t obj = {
		.vertices = NULL,
		.base_faces = NULL,
		.faces = NULL,
		.t_vertices = NULL,
		.x = 0,
		.y = 0,
		.z = 0,
		.rx = 0,
		.ry = 0,
		.rz = 0,
		.tx = 0,
		.ty = 0,
		.tz = 0,
		.ax = 0,
		.ay = 0,
		.az = 0,
		.sx = 0,
		.sy = 0,
		.radius = 10,
		.sradius = 10,
		//bools
		.visible = 1,
		.render = 1,
		.background = 0,
		.collision_x = 1,
		.collision_y = 0,
		.collision_down = 0,
		.collision_up = 0,
		.collision_left = 0,
		.ring = 0,
		//end bools
		.min_x = 100,
		.min_y = 100,
		.min_z = 100,
		.max_x = -100,
		.max_y = -100,
		.max_z = -100,
		.vx = 0,
		.vy = 0,
		.vz = 0,
		.age = 0,
		.health = 2
	};
	
	add_object_to_list(obj);
	
	return obj;
}

void load_object(
	float * object_vertices, unsigned short num_vertices,
	char * object_faces, unsigned short num_faces,
	int x, int y, int z, int ax, int ay, int az,
	int obstacle, int color_mode, int color){
	
	object_t object = new_object();
	
	object.vertices = malloc(sizeof (float) * num_vertices);
	for(int i = 0; i < num_vertices; i++)
		object.vertices[i] = object_vertices[i];
	
	object.faces = (char **)malloc(sizeof (char *) * num_faces);
	
	if (color_mode == k_preset_color){
		//use native faces
		for(int i = 0; i < num_faces; i++)
			object.faces[i] = (char *)malloc(sizeof (char) * 1);
		
	} else {
		//make a backup copy of faces
		object.base_faces = malloc(sizeof (char) * num_faces);
		for(int i = 0; i < num_faces; i++)
			object.base_faces[i] = object_faces[i];
		//in the lua code, the following chunk
		//just turns object.faces into a 2d array
		
		//with object.faces always being a 2d array
		//only here does it have multiple rows
		for(int i = 0; i < num_faces; i++)
			object.faces[i] = (char *)malloc(sizeof (char) * num_faces);
		
		for(int i = 0; i < num_faces; i++){
			for(int j = 0; j < num_faces; j++){
				object.faces[i][j]=object_faces[i][j];
			}
		}
	}	
	
}

void load_temple(){
	
	init_stars();
	
	for(int i = 0; i < 5; i++){
		unsigned char l = 30;
		unsigned char x = sin(i/5)*l;
		unsigned char z = cos(i/5)*l;
		load_object(
			column_v_string,
			(sizeof(column_v_string)/sizeof(float)),
			column_f_string,
			(sizeof(column_f_string)/sizeof(char)),
			x, 0, z, 0, 0, 0, 1, k_colorize_static, 9
		);
		
		
	}
	
}

void update_temple(){}
void draw_temple_background(){}

void init(){
	
	init_3d();
	
	load_scene(&load_temple, &update_temple, &draw_temple_background);
	
}

void update(){
	
}

void draw(){
	
}

int main(){
	
	srand(time(NULL));
	
	init();
	
	while (!quit){
		update();
		draw();
	}
	
	if(object_list != NULL) free(object_list);
	
	return 0;
}
