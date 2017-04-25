#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

#define DRAW_SDL 1

#if DRAW_SDL
SDL_Window * window = NULL;
SDL_Renderer * renderer = NULL;
#endif

const int SCREEN_WIDTH = 128;
const int SCREEN_HEIGHT = 128;
const int k_x_center = 64;
const int k_y_center = 64;

unsigned char quit = 0;
unsigned int cur_frame = 0;
float light1_x = .1;
float light1_y = .35;
float light1_z = .2;
float t_light_x = 0;
float t_light_y = 0;
float t_light_z = 0;
void (*scene_update_func)();
void (*scene_background_func)();
int k_colorize_static = 1;
int k_colorize_dynamic = 2;
int k_multi_color_static = 3;
int k_multi_color_dynamic = 4;
int k_preset_color = 5;
int k_screen_scale = 80;
int k_color1 = 3;
int k_color2 = 4;
float k_ambient = .3;
float k_friction = .7;
int z_clip = -3;
int z_max = -50;
float mat00 = 0;
float mat10 = 0;
float mat20 = 0;
float mat01 = 0;
float mat11 = 0;
float mat21 = 0;
float mat02 = 0;
float mat12 = 0;
float mat22 = 0;
float cam_x = 0;
float cam_y = 0;
float cam_z = 0;
float cam_ax = 0;
float cam_ay = 0;
float cam_az = 0;
float cam_mat00 = 0;
float cam_mat10 = 0;
float cam_mat20 = 0;
float cam_mat01 = 0;
float cam_mat11 = 0;
float cam_mat21 = 0;
float cam_mat02 = 0;
float cam_mat12 = 0;
float cam_mat22 = 0;

unsigned char pico_palette[][3] = {
	{0x00, 0x00, 0x00},
	{0x1D, 0x2B, 0x53},
	{0x7E, 0x25, 0x53},
	{0x00, 0x87, 0x51},
	{0xAB, 0x52, 0x36},
	{0x5F, 0x57, 0x4F},
	{0xC2, 0xC3, 0xC7},
	{0xFF, 0xF1, 0xE8},
	{0xFF, 0x00, 0x4D},
	{0xFF, 0xA3, 0x00},
	{0xFF, 0xEC, 0x27},
	{0x00, 0xE4, 0x36},
	{0x29, 0xAD, 0xFF},
	{0x83, 0x76, 0x9C},
	{0xFF, 0x77, 0xA8},
	{0xFF, 0xCC, 0xAA}
};

unsigned char double_color_list[32][10] = {
	{0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0},

	{0,0,1,1,1,1,13,13,12,12},
	{0,0,0,1,1,1,1,13,13,12},
	
	{2,2,2,2,8,8,14,14,14,15},
	{0,1,1,2,2,8,8,8,14,14},
	
	{1,1,1,1,3,3,11,11,10,10},
	{0,1,1,1,1,3,3,11,11,10},
	
	{1,1,2,2,4,4,9,9,10,10},
	{0,1,1,2,2,4,4,9,9,10},
	
	{0,0,1,1,5,5,13,13,6,6},
	{0,0,0,1,1,5,5,13,13,6},
	
	{1,1,5,5,6,6,6,6,7,7},
	{0,1,1,5,5,6,6,6,6,7},
	
	{5,5,6,6,7,7,7,7,7,7},
	{0,5,5,6,6,7,7,7,7,7},
	
	{2,2,2,2,8,8,14,14,15,15},
	{0,2,2,2,2,8,8,14,14,15},
	
	{2,2,4,4,9,9,15,15,7,7},
	{0,2,2,4,4,9,9,15,15,7},
	
	{4,4,9,9,10,10,7,7,7,7},
	{0,4,4,9,9,10,10,7,7,7},
	
	{1,1,3,3,11,11,10,10,7,7},
	{0,1,1,3,3,11,11,10,10,7},
	
	{13,13,13,12,12,12,6,6,7,7},
	{0,5,13,13,12,12,12,6,6,7},
	
	{1,1,5,5,13,13,6,6,7,7},
	{0,1,1,5,5,13,13,6,6,7},
	
	{2,2,2,2,14,14,15,15,7,7},
	{0,2,2,2,2,14,14,15,15,7},
	
	{4,4,9,9,15,15,7,7,7,7},
	{0,4,4,9,9,15,15,7,7,7}
};

float pyramid_v_string[][3] = {
	{ 0.0, -2.062, -4.0 },
	{ 3.461, -2.062, 2 },
	{ 0.0, 3.59, 0.0 },
	{-3.465, -2.062, 2 }
};

unsigned char pyramid_f_string[][3] = {
	{ 0x01, 0x02, 0x03 },
	{ 0x00, 0x02, 0x01 },
	{ 0x03, 0x02, 0x00 },
	{ 0x00, 0x01, 0x03 }
};

float column_v_string[][3] = {
	{ -2.0, -0.01171, 2.0 },
	{ -2.0, -0.01171, -2.0 },
	{ 2, -0.01171, -2.0 },
	{ 2, -0.01171, 2.0 },
	{ -2, 1.078, 2 },
	{ -2, 1.078, -2 },
	{ 2, 1.078, -2 },
	{ 2, 1.078, 2 },
	{ -1.043, 2.609, 1.039 },
	{ -1.043, 2.609, -1.043 },
	{ 1.039, 2.609, -1.043 },
	{ 1.039, 2.609, 1.039 },
	{ 0.0, 16.234, 1.473 },
	{ -1.477, 16.234, 0 },
	{ 0, 16.234, -1.477},
	{ 1.473, 16.234, 0.0},
	{ 0, 17.344, 2.535 },
	{ -2.539, 17.344, 0 },
	{ 0, 17.344, -2.539 },
	{ 2.535, 17.344, 0}
};

unsigned char column_f_string[][3] = {
	{ 0x05, 0x01, 0x00 },
	{ 0x06, 0x02, 0x01 },
	{ 0x07, 0x03, 0x02 },
	{ 0x04, 0x00, 0x03 },
	{ 0x04, 0x07, 0x0b },
	{ 0x0f, 0x0c, 0x0b },
	{ 0x07, 0x06, 0x0a },
	{ 0x06, 0x05, 0x09 },
	{ 0x05, 0x04, 0x08 },
	{ 0x0f, 0x13, 0x10 },
	{ 0x0e, 0x0f, 0x0a },
	{ 0x0d, 0x0e, 0x09 },
	{ 0x0c, 0x0d, 0x08 },
	{ 0x0e, 0x12, 0x13 },
	{ 0x0d, 0x11, 0x12 },
	{ 0x0c, 0x10, 0x11 },
	{ 0x0c, 0x08, 0x0b },
	{ 0x0f, 0x0b, 0x0a },
	{ 0x0e, 0x0a, 0x09 },
	{ 0x0d, 0x09, 0x08 },
	{ 0x04, 0x05, 0x00 },
	{ 0x05, 0x06, 0x01 },
	{ 0x06, 0x07, 0x02 },
	{ 0x07, 0x04, 0x03 },
	{ 0x08, 0x04, 0x0b },
	{ 0x0b, 0x07, 0x0a },
	{ 0x0a, 0x06, 0x09 },
	{ 0x09, 0x05, 0x08 },
	{ 0x0c, 0x0f, 0x10 },
	{ 0x0f, 0x0e, 0x13 },
	{ 0x0e, 0x0d, 0x12 },
	{ 0x0d, 0x0c, 0x11 }
};

float hole_v_string[][3] = {
	{ 2.25, -2.25, -2.25 },
	{ 2.25, -2.25, 2.25 },
	{ -2.25, -2.25, 2.25 },
	{ -2.25, -2.25, -2.254 },
	{ 2.25, 2.25, -2.25 },
	{ 2.246, 2.25, 2.25 },
	{ -2.254, 2.25, 2.246 },
	{ -2.25, 2.25, -2.25 },
	{ 1.125, 2.25, -1.125 },
	{ 1.121, 2.25, 1.125 },
	{ -1.125, 2.25, 1.125 },
	{ -1.125, 2.25, -1.125 },
	{ 1.125, -2.25, -1.125 },
	{ 1.125, -2.25, 1.125 },
	{ -1.125, -2.25, 1.125 },
	{ -1.125, -2.25, -1.129 }
};

unsigned char hole_f_string[][3] = {
	{ 0x02, 0x03, 0x0f },
	{ 0x06, 0x0a, 0x0b },
	{ 0x00, 0x04, 0x05 },
	{ 0x01, 0x05, 0x06 },
	{ 0x06, 0x07, 0x03 },
	{ 0x00, 0x03, 0x07 },
	{ 0x0a, 0x09, 0x0d },
	{ 0x05, 0x09, 0x0a },
	{ 0x07, 0x0b, 0x08 },
	{ 0x04, 0x08, 0x09 },
	{ 0x08, 0x0c, 0x0d },
	{ 0x02, 0x0e, 0x0d },
	{ 0x00, 0x0c, 0x0f },
	{ 0x01, 0x0d, 0x0c },
	{ 0x0f, 0x0c, 0x08 },
	{ 0x0a, 0x0e, 0x0f },
	{ 0x0e, 0x02, 0x0f },
	{ 0x07, 0x06, 0x0b },
	{ 0x01, 0x00, 0x05 },
	{ 0x02, 0x01, 0x06 },
	{ 0x02, 0x06, 0x03 },
	{ 0x04, 0x00, 0x07 },
	{ 0x0e, 0x0a, 0x0d },
	{ 0x06, 0x05, 0x0a },
	{ 0x04, 0x07, 0x08 },
	{ 0x05, 0x04, 0x09 },
	{ 0x09, 0x08, 0x0d },
	{ 0x01, 0x02, 0x0d },
	{ 0x03, 0x00, 0x0f },
	{ 0x00, 0x01, 0x0c },
	{ 0x0b, 0x0f, 0x08 },
	{ 0x0b, 0x0a, 0x0f }
};

float fountain_v_string[][3] = {
	{ 0, 0.8164, -1.5 },
	{ 0, 2.652, -1.5 },
	{ 1.426, 0.8164, -0.4648 },
	{ 1.426, 2.652, -0.4648 },
	{ 0.8789, 0.8164, 1.211 },
	{ 0.8789, 2.652, 1.211 },
	{ -0.8828, 0.8164, 1.211 },
	{ -0.8828, 2.652, 1.211 },
	{ -1.43, 0.8164, -0.4648 },
	{ -1.43, 2.652, -0.4648 },
	{ 0, 4.352, -3.957 },
	{ 3.762, 4.352, -1.227 },
	{ 2.324, 4.352, 3.199 },
	{ -2.328, 4.352, 3.199 },
	{ -3.766, 4.352, -1.227 },
	{ 0, 5.371, -3.957 },
	{ 3.762, 5.371, -1.227 },
	{ 2.324, 5.371, 3.199 },
	{ -2.328, 5.371, 3.199 },
	{ -3.766, 5.371, -1.227 },
	{ 0, 0.0547, -2.547 },
	{ 2.418, 0.0547, -0.7891 },
	{ 1.492, 0.0547, 2.059 },
	{ -1.496, 0.0547, 2.059 },
	{ -2.422, 0.0547, -0.7891 }
};

unsigned char fountain_f_string[][3] = {
	{ 0x01, 0x03, 0x02 },
	{ 0x03, 0x05, 0x04 },
	{ 0x05, 0x07, 0x06 },
	{ 0x09, 0x0e, 0x0a },
	{ 0x09, 0x01, 0x00 },
	{ 0x07, 0x09, 0x08 },
	{ 0x00, 0x14, 0x18 },
	{ 0x0e, 0x13, 0x0f },
	{ 0x07, 0x0d, 0x0e },
	{ 0x05, 0x0c, 0x0d },
	{ 0x03, 0x0b, 0x0c },
	{ 0x01, 0x0a, 0x0b },
	{ 0x10, 0x0f, 0x13 },
	{ 0x0d, 0x12, 0x13 },
	{ 0x0c, 0x11, 0x12 },
	{ 0x0b, 0x10, 0x11 },
	{ 0x0a, 0x0f, 0x10 },
	{ 0x08, 0x18, 0x17 },
	{ 0x04, 0x06, 0x17 },
	{ 0x02, 0x04, 0x16 },
	{ 0x02, 0x15, 0x14 },
	{ 0x00, 0x01, 0x02 },
	{ 0x02, 0x03, 0x04 },
	{ 0x04, 0x05, 0x06 },
	{ 0x01, 0x09, 0x0a },
	{ 0x08, 0x09, 0x00 },
	{ 0x06, 0x07, 0x08 },
	{ 0x08, 0x00, 0x18 },
	{ 0x0a, 0x0e, 0x0f },
	{ 0x09, 0x07, 0x0e },
	{ 0x07, 0x05, 0x0d },
	{ 0x05, 0x03, 0x0c },
	{ 0x03, 0x01, 0x0b },
	{ 0x12, 0x11, 0x10 },
	{ 0x12, 0x10, 0x13 },
	{ 0x0d, 0x0c, 0x12 },
	{ 0x0e, 0x0d, 0x13 },
	{ 0x0c, 0x0b, 0x11 },
	{ 0x0b, 0x0a, 0x10 },
	{ 0x06, 0x08, 0x17 },
	{ 0x16, 0x04, 0x17 },
	{ 0x15, 0x02, 0x16 },
	{ 0x00, 0x02, 0x14 }
};

typedef struct {
	void *fake;
} particle_list_t;

typedef struct {
	unsigned short x;
	unsigned short y;
} star_t;
star_t star_list[150];

typedef struct {
	float ** vertices;
	unsigned char ** base_faces;
	unsigned char ** faces;
	float ** t_vertices;
	int num_vertices;
	int num_faces;
	float x;
	float y;
	float z;
	//~ int rx;
	//~ int ry;
	//~ int rz;
	float tx;
	float ty;
	float tz;
	float ax;
	float ay;
	float az;
	float sx;
	float sy;
	int color;
	int color_mode;
	float radius;
	float sradius;
	int obstacle;
	int visible;
	int render;
	int background;
	int collision_x;
	int collision_y;
	int collision_down;
	int collision_up;
	int collision_left;
	int ring;
	float min_x;
	float min_y;
	float min_z;
	float max_x;
	float max_y;
	float max_z;
	float vx;
	float vy;
	float vz;
	int age;
	int health;
} object_t;

typedef struct {
	float p1x;
	float p1y;
	float p2x;
	float p2y;
	float p3x;
	float p3y;
	float tz;
	int c1;
	int c2;
}triangle_t;

triangle_t ** triangle_list = NULL;
int triangle_list_used = 0;
int triangle_list_length = 0;

object_t ** object_list = NULL;
int object_list_used = 0;
int object_list_length = 0;

object_t * obstacle_list = NULL;
int obstacle_list_used = 0;
int obstacle_list_length = 0;

object_t * hole = NULL;
object_t * pyramids[5] = { NULL };
object_t * player = NULL;


object_t * add_object_to_list(){
	if (object_list_used == object_list_length){
		object_list_length += 2;
		object_list = realloc(object_list, (sizeof(object_t*)) * object_list_length);
	}
	
	object_t * return_object = malloc(sizeof (object_t));
	object_list[object_list_used] = return_object;
	object_list_used++;
	
	return return_object;
}

void add_obstacle_to_list(object_t * new_obj){
	
	if (obstacle_list_used == obstacle_list_length){
		obstacle_list_length += 2;
		obstacle_list = realloc(obstacle_list, (sizeof(object_t)) * obstacle_list_length);
	}
	
	*(obstacle_list + obstacle_list_used) = *new_obj;
	
	obstacle_list_used++;
}

triangle_t * add_triangle_to_list(){
	
	if (triangle_list_used == triangle_list_length){
		triangle_list_length += 2;
		triangle_list = realloc(triangle_list, (sizeof(triangle_t*)) * triangle_list_length);
	}
	
	// pointer of triangle_list[index] is now new_triangle's pointer
	triangle_t * return_triangle = malloc(sizeof (triangle_t));
	triangle_list[triangle_list_used] = return_triangle;
	
	triangle_list_used++;
	//~ printf("%d\n", triangle_list_used);
	
	return return_triangle;
}

void del_triangle_from_list(int i){
	triangle_list[i] = triangle_list[triangle_list_used -1];
	triangle_list_used--;
}

object_t * new_object(){
	
	printf("BEGIN_NEW_OBJECT\n");
	
	object_t * obj = add_object_to_list();
	
	obj->num_faces = 0;
	obj->num_vertices = 0;
	obj->x = 0;
	obj->y = 0;
	obj->z = 0;
	//~ obj->rx = 0;
	//~ obj->ry = 0;
	//~ obj->rz = 0;
	obj->tx = 0;
	obj->ty = 0;
	obj->tz = 0;
	obj->ax = 0;
	obj->ay = 0;
	obj->az = 0;
	obj->sx = 0;
	obj->sy = 0;
	obj->color = 0;
	obj->color_mode = 0;
	obj->radius = 10;
	obj->sradius = 10;
	//bools
	obj->obstacle = 0;
	obj->visible = 1;
	obj->render = 1;
	obj->background = 0;
	obj->collision_x = 1;
	obj->collision_y = 0;
	obj->collision_down = 0;
	obj->collision_up = 0;
	obj->collision_left = 0;
	obj->ring = 0;
	//end bools
	obj->min_x = 100;
	obj->min_y = 100;
	obj->min_z = 100;
	obj->max_x = -100;
	obj->max_y = -100;
	obj->max_z = -100;
	obj->vx = 0;
	obj->vy = 0;
	obj->vz = 0;
	obj->age = 0;
	obj->health = 2;
	
	printf("END_NEW_OBJECT\n");
	
	return obj;
}

triangle_t * new_triangle(
	float p1x, float p1y, float p2x, float p2y, float p3x, float p3y,
	float tz, int c1, int c2
	){
	
	//~ printf("BEGIN_NEW_TRIANGLE\n");
	
	triangle_t * tri = add_triangle_to_list();
	
	tri->p1x = p1x;
	tri->p1y = p1y;
	tri->p2x = p2x;
	tri->p2y = p2y;
	tri->p3x = p3x;
	tri->p3y = p3y;
	tri->tz = tz;
	tri->c1 = c1;
	tri->c2 = c2;
	
	
	//~ printf("p1x: %f\n", p1x);
	//~ printf("p1y: %f\n", p1y);
	//~ printf("p2x: %f\n", p2x);
	//~ printf("p2y: %f\n", p2y);
	//~ printf("p3x: %f\n", p3x);
	//~ printf("p3y: %f\n", p3y);
	//~ printf("tz : %f\n", tz );
	//~ printf("c1 : %d\n", c1 );
	//~ printf("c2 : %d\n", c2 );
	
	//~ printf("END_NEW_TRIANGLE\n");
	
	return tri;
}


void init_player(){
	
	printf("BEGIN_INIT_PLAYER\n");
	//~ if (player == NULL){
		player = new_object();
	//~ }
	
	
	player->min_x = -4.5;
	player->min_y = -4.5;
	player->min_z = -4.5;
	player->max_x = 4.5;
	player->max_y = 4.5;
	player->max_z = 4.5;
	player->x = 0;
	player->y = 8;
	player->z = 15;
	player->ax = 0;
	player->ay = 0;
	player->az = 0;
	player->vx = 0;
	player->vy = 0;
	player->vz = 0;
	
	player->vertices = NULL;
	player->t_vertices = NULL;
	player->faces = NULL;
	player->base_faces = NULL;
	
	//~ printf("player.min_x: %f\n", player.min_x);
	//~ printf("player.min_y: %f\n", player.min_y);
	//~ printf("player.min_z: %f\n", player.min_z);
	//~ printf("player.max_x: %f\n", player.max_x);
	//~ printf("player.max_y: %f\n", player.max_y);
	//~ printf("player.max_z: %f\n", player.max_z);
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	//~ printf("player.ax: %f\n", player.ax);
	//~ printf("player.ay: %f\n", player.ay);
	//~ printf("player.az: %f\n", player.az);
	//~ printf("player.vx: %f\n", player.vx);
	//~ printf("player.vy: %f\n", player.vy);
	//~ printf("player.vz: %f\n", player.vz);
	printf("END_INIT_PLAYER\n");
}

void normalize(float * norm_x, float * norm_y, float * norm_z){
	printf("BEGIN_NORMALIZE\n");
	*norm_x *= 4;
	*norm_y *= 4;
	*norm_z *= 4;
	
	float inv_dist=1/sqrt((*norm_x) * (*norm_x)
		+ (*norm_y) * (*norm_y) 
		+ (*norm_z) * (*norm_z));
	
	*norm_x *= inv_dist;
	*norm_y *= inv_dist;
	*norm_z *= inv_dist;
	printf("END_NORMALIZE\n");
}

void init_light(){
	printf("BEGIN_INIT_LIGHT\n");
	//~ printf("prelight1_x: %f\n", light1_x);
	//~ printf("prelight1_y: %f\n", light1_y);
	//~ printf("prelight1_z: %f\n", light1_z);
	normalize(&light1_x, &light1_y, &light1_z);
	//~ printf("light1_x: %f\n", light1_x);
	//~ printf("light1_y: %f\n", light1_y);
	//~ printf("light1_z: %f\n", light1_z);
	printf("END_INIT_LIGHT\n");
}

void init_3d(){
	
	printf("BEGIN_INIT_3D\n");
	init_light();
	
	if (object_list != NULL){
		for(int i = 0; i < object_list_used; i++){
			for(int j = 0; j < object_list[i]->num_vertices; j++){
				free(object_list[i]->vertices);
				free(object_list[i]->t_vertices);
			}
			for(int j = 0; j < object_list[i]->num_faces; j++){
				free(object_list[i]->faces);
				free(object_list[i]->base_faces);
			}
		}
		object_list_used = 0;
		object_list = NULL;
	}
	
	init_player();
	
	//~ particle_list_t p_l = { .fake = NULL };
	
	printf("END_INIT_3D\n");
}

void load_scene(void (*init_func)(), void (*update_func)(), void (*background_func)()){
	printf("BEGIN_LOAD_SCENE\n");
	scene_update_func = update_func;
	scene_background_func = background_func;
	init_3d();
	init_func();
	printf("END_LOAD_SCENE\n");
}

void init_stars(){
	printf("BEGIN_INIT_STARS\n");
	for(int i = 0; i < 150; i++){
		star_list[i].x = rand() % 508;
		star_list[i].y = rand() % 55;
	}
	printf("END_INIT_STARS\n");
}

float pico_sin(float in){
	return (sin(in * M_PI * 2 * -1));
}

float pico_cos(float in){
	return cos(in * M_PI * 2);
}

void generate_matrix_transform(float xa, float ya, float za){

	printf("BEGIN_GMT\n");
	
	float sx=pico_sin(xa);
	float sy=pico_sin(ya);
	float sz=pico_sin(za);
	float cx=pico_cos(xa);
	float cy=pico_cos(ya);
	float cz=pico_cos(za);
	
	//~ printf("sx: %f\n", sx);
	//~ printf("sy: %f\n", sy);
	//~ printf("sz: %f\n", sz);
	//~ printf("cx: %f\n", cx);
	//~ printf("cy: %f\n", cy);
	//~ printf("cz: %f\n", cz);
	
	mat00=cz*cy;
	mat10=-1*sz;
	mat20=cz*sy;
	mat01=cx*sz*cy+sx*sy;
	mat11=cx*cz;
	mat21=cx*sz*sy-sx*cy;
	mat02=sx*sz*cy-cx*sy;
	mat12=sx*cz;
	mat22=sx*sz*sy+cx*cy;
	
	//~ printf("mat00: %f\n", mat00);
	//~ printf("mat10: %f\n", mat10);
	//~ printf("mat20: %f\n", mat20);
	//~ printf("mat01: %f\n", mat01);
	//~ printf("mat11: %f\n", mat11);
	//~ printf("mat21: %f\n", mat21);
	//~ printf("mat02: %f\n", mat02);
	//~ printf("mat12: %f\n", mat12);
	//~ printf("mat22: %f\n", mat22);

	printf("END_GMT\n");
}

void generate_cam_matrix_transform(float xa, float ya, float za){

	printf("BEGIN_CAM_GMT\n");
	
	float sx=pico_sin(xa);
	float sy=pico_sin(ya);
	float sz=pico_sin(za);
	float cx=pico_cos(xa);
	float cy=pico_cos(ya);
	float cz=pico_cos(za);
	
	//~ printf("sx: %f\n", sx);
	//~ printf("sy: %f\n", sy);
	//~ printf("sz: %f\n", sz);
	//~ printf("cx: %f\n", cx);
	//~ printf("cy: %f\n", cy);
	//~ printf("cz: %f\n", cz);
	
	cam_mat00=cz*cy;
	cam_mat10=-1*sz;
	cam_mat20=cz*sy;
	cam_mat01=cx*sz*cy+sx*sy;
	cam_mat11=cx*cz;
	cam_mat21=cx*sz*sy-sx*cy;
	cam_mat02=sx*sz*cy-cx*sy;
	cam_mat12=sx*cz;
	cam_mat22=sx*sz*sy+cx*cy;

	//~ printf("cam_mat00: %f\n", cam_mat00);
	//~ printf("cam_mat10: %f\n", cam_mat10);
	//~ printf("cam_mat20: %f\n", cam_mat20);
	//~ printf("cam_mat01: %f\n", cam_mat01);
	//~ printf("cam_mat11: %f\n", cam_mat11);
	//~ printf("cam_mat21: %f\n", cam_mat21);
	//~ printf("cam_mat02: %f\n", cam_mat02);
	//~ printf("cam_mat12: %f\n", cam_mat12);
	//~ printf("cam_mat22: %f\n", cam_mat22);

	printf("END_CAM_GMT\n");

}

void rotate_point(float f0, float f1, float f2, float * vx, float * vy, float * vz){
	printf("BEGIN_ROTATE_POINT\n");
	
	//~ printf("in0: %f\n", f0);
	//~ printf("in1: %f\n", f1);
	//~ printf("in2: %f\n", f2);
	*vx = (f0 * mat00 + f1 * mat10 + f2 * mat20);
	*vy = (f0 * mat01 + f1 * mat11 + f2 * mat21);
	*vz = (f0 * mat02 + f1 * mat12 + f2 * mat22);
	
	//~ printf("mat00: %f\n", mat00);
	//~ printf("mat10: %f\n", mat10);
	//~ printf("mat20: %f\n", mat20);
	//~ printf("mat01: %f\n", mat01);
	//~ printf("mat11: %f\n", mat11);
	//~ printf("mat21: %f\n", mat21);
	//~ printf("mat02: %f\n", mat02);
	//~ printf("mat12: %f\n", mat12);
	//~ printf("mat22: %f\n", mat22);
	
	//~ printf("out0: %f\n", *vx);
	//~ printf("out1: %f\n", *vy);
	//~ printf("out2: %f\n", *vz);
	
	printf("END_ROTATE_POINT\n");
}

void rotate_point_arrays(float v[3], float t[3]){
	printf("BEGIN_ROTATE_POINT_A\n");
	
	//~ printf("in0: %f\n", v[0]);
	//~ printf("in1: %f\n", v[1]);
	//~ printf("in2: %f\n", v[2]);
		
	t[0] = (v[0] * mat00 + v[1] * mat10 + v[2] * mat20);
	t[1] = (v[0] * mat01 + v[1] * mat11 + v[2] * mat21);
	t[2] = (v[0] * mat02 + v[1] * mat12 + v[2] * mat22);
	
	//~ printf("mat00: %f\n", mat00);
	//~ printf("mat10: %f\n", mat10);
	//~ printf("mat20: %f\n", mat20);
	//~ printf("mat01: %f\n", mat01);
	//~ printf("mat11: %f\n", mat11);
	//~ printf("mat21: %f\n", mat21);
	//~ printf("mat02: %f\n", mat02);
	//~ printf("mat12: %f\n", mat12);
	//~ printf("mat22: %f\n", mat22);
	
	//~ printf("out0: %f\n", t[0]);
	//~ printf("out1: %f\n", t[1]);
	//~ printf("out2: %f\n", t[2]);
	
	printf("END_ROTATE_POINT_A\n");
}

void transform_object(object_t * object){
	//shouldn't this not be happening if all the axes are 0?
	//~ printf("object.visible: %d\n", object->visible);
		printf("BEGIN_TRANSFORM_OBJ\n");
	if(object->visible == 1){
		
		//~ printf("object.ax: %f\n", object->ax);
		//~ printf("object.ay: %f\n", object->ay);
		//~ printf("object.az: %f\n", object->az);
		generate_matrix_transform(object->ax, object->ay, object->az);
		for(int i = 0; i < object->num_vertices; i++){
			//pass direct access to objects verts
			rotate_point_arrays(object->vertices[i], object->t_vertices[i]);
		}
	}
		printf("END_TRANSFORM_OBJ\n");
}

void set_radius(object_t * object){
		printf("BEGIN_SET_RADIUS\n");
	
	for(int i = 0; i < object->num_vertices; i++){
		object->radius = MAX(
			object->radius, 
			(
				object->vertices[i][0] * object->vertices[i][0] + 
				object->vertices[i][1] * object->vertices[i][1] + 
				object->vertices[i][2] * object->vertices[i][2]
			)
		);
		//~ printf("object.radius: %f\n", object->radius);
	}
	object->radius=sqrt(object->radius);
		//~ printf("object.radius: %f\n", object->radius);
	
		printf("END_SET_RADIUS\n");
}

void set_bounding_box(object_t * object){
		printf("BEGIN_SET_BOUNDING_BOX\n");
	
	for(int i = 0; i < object->num_vertices; i++){
		if( object->min_x > object->t_vertices[i][0] )
			object->min_x = object->t_vertices[i][0];
		if( object->min_y > object->t_vertices[i][1] )
			object->min_y = object->t_vertices[i][1];
		if( object->min_z > object->t_vertices[i][2] )
			object->min_z = object->t_vertices[i][2];
		
		if( object->max_x < object->t_vertices[i][0] )
			object->max_x = object->t_vertices[i][0];
		if( object->max_y < object->t_vertices[i][1] )
			object->max_y = object->t_vertices[i][1];
		if( object->max_z < object->t_vertices[i][2] )
			object->max_z = object->t_vertices[i][2];
		
		
		//~ printf("vertex[0]: %f\n", object->t_vertices[i][0]);
		//~ printf("vertex[1]: %f\n", object->t_vertices[i][1]);
		//~ printf("vertex[2]: %f\n", object->t_vertices[i][2]);
		//~ printf("object.min_x: %f\n", object->min_x);
		//~ printf("object.min_y: %f\n", object->min_y);
		//~ printf("object.min_z: %f\n", object->min_z);
		//~ printf("object.max_x: %f\n", object->max_x);
		//~ printf("object.max_y: %f\n", object->max_y);
		//~ printf("object.max_z: %f\n", object->max_z);
	}
		printf("END_SET_BOUNDING_BOX\n");

}

void vector_cross_3d(
	float px, float py, float pz,
	float ax, float ay, float az,
	float bx, float by, float bz,
	float * nx, float * ny, float * nz){
	
	printf("BEGIN_VECTOR_CROSS_3D\n");
	
	ax -= px;
	ay -= py;
	az -= pz;
	bx -= px;
	by -= py;
	bz -= pz;
	
	//~ printf("ax: %f\n", ax);
	//~ printf("ay: %f\n", ay);
	//~ printf("az: %f\n", az);
	//~ printf("bx: %f\n", bx);
	//~ printf("by: %f\n", by);
	//~ printf("bz: %f\n", bz);
	
	*nx = ay * bz - az * by;
	*ny = az * bx - ax * bz;
	*nz = ax * by - ay * bx;
	
	//~ printf("nx: %f\n", *nx);
	//~ printf("ny: %f\n", *ny);
	//~ printf("nz: %f\n", *nz);
	
	
	printf("END_VECTOR_CROSS_3D\n");
}

float vector_dot_3d(float ax, float ay, float az, float bx, float by, float bz){
	
	printf("BEGIN_VECTOR_DOT_3D\n");
	//~ printf("vd3d: %f\n", (ax * bx + ay * by + az * bz));
	printf("END_VECTOR_DOT_3D\n");
	return (ax * bx + ay * by + az * bz);
}

void color_shade(unsigned char color, float brightness, unsigned char * f4, unsigned char * f5){
	printf("BEGIN_COLOR_SHADE\n");
	int b = (int)((brightness - .001) * 10);
	unsigned char c = (color + 1) * 2;
	*f4 = double_color_list[c - 2][b - 1];
	*f5 = double_color_list[c - 1][b - 1];
	
	//~ printf("b: %d\n", b);
	//~ printf("color: %d\n", color);
	//~ printf("brightness: %f\n", brightness);
	//~ printf("c: %d\n", c);
	//~ printf("f4: %d\n", *f4);
	//~ printf("f5: %d\n", *f5);
	printf("END_COLOR_SHADE\n");
}

void color_faces(object_t * object){
	printf("BEGIN_COLOR_FACES\n");
	
	
	for(int i = 0; i < object->num_faces; i++){
		unsigned char * face = object->faces[i];
		float p1x = object->t_vertices[face[0]][0];
		float p1y = object->t_vertices[face[0]][1];
		float p1z = object->t_vertices[face[0]][2];
		float p2x = object->t_vertices[face[1]][0];
		float p2y = object->t_vertices[face[1]][1];
		float p2z = object->t_vertices[face[1]][2];
		float p3x = object->t_vertices[face[2]][0];
		float p3y = object->t_vertices[face[2]][1];
		float p3z = object->t_vertices[face[2]][2];
	
		float nx, ny, nz;
		vector_cross_3d(
			p1x, p1y, p1z,
			p2x, p2y, p2z,
			p3x, p3y, p3z,
			&nx, &ny, &nz
		);
		
		normalize(&nx, &ny, &nz);
		
		float b = vector_dot_3d(nx, ny, nz, light1_x, light1_y, light1_z);
		
		float mid;
		if ( b <= 0 ) mid = 0 + k_ambient;
		else if ( b >= 1) mid = (1-k_ambient) + k_ambient;
		else mid = b * (1-k_ambient) + k_ambient;
		
		if(object->color_mode == k_multi_color_dynamic){
			color_shade(object->base_faces[i][3], mid, &face[3], &face[4]);
		} else {
			color_shade(object->color, mid, &face[3], &face[4]);			
		}
		
		//~ printf("face3: %d\n", face[3]);
		//~ printf("face4: %d\n", face[4]);
		
	}
	
	printf("END_COLOR_FACES\n");
}

object_t * load_object(
	float object_vertices[][3], unsigned short num_vertices,
	unsigned char object_faces[][3], unsigned short num_faces,
	float x, float y, float z, float ax, float ay, float az,
	int obstacle, int color_mode, int color){
	
	printf("BEGIN_LOAD_OBJECT\n");
	
	object_t * object = new_object();
	
	object->num_vertices = num_vertices;
	object->num_faces = num_faces;
	
	//~ printf("object.num_faces: %d\n", object->num_faces);
	//~ printf("object.num_vertices: %d\n", object->num_vertices);
	//~ printf("object.x: %f\n", object->x);
	//~ printf("object.y: %f\n", object->y);
	//~ printf("object.z: %f\n", object->z);
	//~ printf("object.rx: %d\n", object->rx);
	//~ printf("object.ry: %d\n", object->ry);
	//~ printf("object.rz: %d\n", object->rz);
	//~ printf("object.tx: %f\n", object->tx);
	//~ printf("object.ty: %f\n", object->ty);
	//~ printf("object.tz: %f\n", object->tz);
	//~ printf("object.ax: %f\n", object->ax);
	//~ printf("object.ay: %f\n", object->ay);
	//~ printf("object.az: %f\n", object->az);
	//~ printf("object.sx: %f\n", object->sx);
	//~ printf("object.sy: %f\n", object->sy);
	//~ printf("object.color: %d\n", color);
	//~ printf("object.color_mode: %d\n", color_mode);
	//~ printf("object.radius: %f\n", object->radius);
	//~ printf("object.sradius: %f\n", object->sradius);
	//~ //bools
	//~ printf("object.obstacle: %d\n", object->obstacle);
	//~ printf("object.visible: %d\n", object->visible);
	//~ printf("object.render: %d\n", object->render);
	//~ printf("object.background: %d\n", object->background);
	//~ printf("object.collision_x: %d\n", object->collision_x);
	//~ printf("object.collision_y: %d\n", object->collision_y);
	//~ printf("object.collision_down: %d\n", object->collision_down);
	//~ printf("object.collision_up: %d\n", object->collision_up);
	//~ printf("object.collision_left: %d\n", object->collision_left);
	//~ printf("object.ring: %d\n", object->ring);
	//~ //end bools
	//~ printf("object.min_x: %f\n", object->min_x);
	//~ printf("object.min_y: %f\n", object->min_y);
	//~ printf("object.min_z: %f\n", object->min_z);
	//~ printf("object.max_x: %f\n", object->max_x);
	//~ printf("object.max_y: %f\n", object->max_y);
	//~ printf("object.max_z: %f\n", object->max_z);
	//~ printf("object.vx: %d\n", object->vx);
	//~ printf("object.vy: %d\n", object->vy);
	//~ printf("object.vz: %d\n", object->vz);
	//~ printf("object.age: %d\n", object->age);
	//~ printf("object.health: %d\n", object->health);
	
	
	//copy verts
	object->vertices = calloc( num_vertices, sizeof(float*) );
	for(int i = 0; i < num_vertices; i++){
		object->vertices[i] = calloc( 3, sizeof(float) );
		for(int j = 0; j < 3; j++){
			object->vertices[i][j] = object_vertices[i][j];
			//~ printf("ivert[%d][%d]: %f\n", i, j, object_vertices[i][j]);
			//~ printf("overt[%d][%d]: %f\n", i, j, object->vertices[i][j]);
		}
	}
	
	//copy for translated verts
	object->t_vertices = calloc( num_vertices, sizeof(float*) );
	for(int i = 0; i < num_vertices; i++){
		object->t_vertices[i] = calloc( 5, sizeof(float) );
		for(int j = 0; j < 3; j++){
			object->t_vertices[i][j] = object_vertices[i][j];
			//~ printf("itvert[%d][%d]: %f\n", i, j, object_vertices[i][j]);
			//~ printf("otvert[%d][%d]: %f\n", i, j, object->t_vertices[i][j]);
		}
	}
	
	
	//copy faces
	object->faces = calloc( num_faces, sizeof(unsigned char*) );
	for(int i = 0; i < num_faces; i++){
		object->faces[i] = calloc( 6, sizeof(unsigned char) );
		for(int j = 0; j < 3; j++){
			object->faces[i][j] = object_faces[i][j];
			//~ printf("iface[%d][%d]: %d\n", i, j, object_faces[i][j]);
		}
	}

	//base faces for shading
	if (color_mode != k_preset_color){
		object->base_faces = calloc( num_faces, sizeof(unsigned char*) );
		for(int i = 0; i < num_faces; i++){
			object->base_faces[i] = calloc( 6, sizeof(unsigned char) );
			for(int j = 0; j < 3; j++){
				object->base_faces[i][j] = object_faces[i][j];
			}
		}
	}
	
	
	
	//move everything above into new_object, and pass it all this shit^^
	
	object->radius = 0;
	object->ax = ax;
	object->ay = ay;
	object->az = az;
	object->num_vertices = num_vertices;
	object->num_faces = num_faces;
	
	
	//~ printf("object.ax: %f\n", object->ax);
	//~ printf("object.ay: %f\n", object->ay);
	//~ printf("object.az: %f\n", object->az);
	
	transform_object(object);
	
	
	set_radius(object);
	set_bounding_box(object);
	
	
	
	object->x = x;
	object->y = y;
	object->z = z;
	
	//~ printf("object.x: %f\n", object->x);
	//~ printf("object.y: %f\n", object->y);
	//~ printf("object.z: %f\n", object->z);
	
	object->color = color;
	object->color_mode = color_mode;
	object->obstacle = obstacle;
	
	//~ printf("object.color: %d\n", object->color);
	//~ printf("object.color_mode: %d\n", object->color_mode);
	
	if(obstacle)
		add_obstacle_to_list(object);
	
	if ( color_mode == k_colorize_static || 
		color_mode == k_colorize_dynamic || 
		color_mode == k_multi_color_static ){
		color_faces(object);
	}
		
	printf("END_LOAD_OBJECT\n");
	
	return object;
}

void load_temple(){
	printf("BEGIN_LOAD_TEMPLE\n");
	
	init_stars();
	
	// create 5 columns
	for(int i = 0; i < 5; i++){
		float l = 30;
		float x = pico_sin((float)(i+1)/5)*l;
		float z = pico_cos((float)(i+1)/5)*l;
		//printf("x: %f\n", x);
		//printf("i: %f\n", (float)(i+1));
		//printf("l: %f\n", l);
		load_object(
			column_v_string,
			(sizeof(column_v_string)/sizeof(column_v_string[0])),
			column_f_string,
			(sizeof(column_f_string)/sizeof(column_f_string[0])),
			x, 0, z, 0, 0, 0, 1, k_colorize_static, 9
		);
	}
	
	//load fountain
	load_object(
		fountain_v_string,
		(sizeof(fountain_v_string)/sizeof(fountain_v_string[0])),
		fountain_f_string,
		(sizeof(fountain_f_string)/sizeof(fountain_f_string[0])),
		0,0,0,0,.08,0,1,k_colorize_static,14
	);
	
	//load hole
	hole = load_object(
		hole_v_string,
		(sizeof(hole_v_string)/sizeof(hole_v_string[0])),
		hole_f_string,
		(sizeof(hole_f_string)/sizeof(hole_f_string[0])),
		0,11,0,.125,.125,.125,0,k_colorize_dynamic,12
	);
	
	// create 5 pyramids
	for(int i = 0; i < 5; i++){
		float l = 25;
		float a = (float)(i+1)/5+.125;
		float x = pico_sin(a)*l;
		float z = pico_cos(a)*l;
		pyramids[i] = load_object(
			pyramid_v_string,
			(sizeof(pyramid_v_string)/sizeof(pyramid_v_string[0])),
			pyramid_f_string,
			(sizeof(pyramid_f_string)/sizeof(pyramid_f_string[0])),
			x, 0, z, 0, 0, 0, 0, k_colorize_static, 13
		);
	}
	
	printf("END_LOAD_TEMPLE\n");
}

void update_temple(){
	printf("BEGIN_UPDATE_TEMPLE\n");
	hole->ax += -.004;
	hole->az += .001;
	hole->ax += .002;
	hole->y = 11 + pico_sin((float)cur_frame/100);
	printf("hole.y: %f\n", hole->y);
		
	for(int i = 0; i < 5; i++){
		int l = 35;
		float a = i / 5 + .125 + cur_frame / 1000;
		pyramids[i]->x = pico_sin(a)*l;
		pyramids[i]->z = pico_cos(a)*l;
		pyramids[i]->y = 10 + pico_sin(a - cur_frame/ 200) * 4;
		pyramids[i]->ax += .003;
		pyramids[i]->ay += .002;
		pyramids[i]->az += .004;
	}
	printf("END_UPDATE_TEMPLE\n");
}

void draw_stars(){
	printf("BEGIN_DRAW_STARS\n");
	#if DRAW_SDL
	SDL_SetRenderDrawColor( renderer, pico_palette[15][0], pico_palette[15][1], pico_palette[15][2], 0xFF );
	for(int i = 0; i < 150; i++){
		SDL_RenderDrawPoint(renderer, (int)((cam_ay * -1)*508+star_list[i].x+cur_frame/20)%508, star_list[i].y);
	}
	#endif
	printf("END_DRAW_STARS\n");
}

void draw_temple_background(){
	
	printf("BEGIN_DRAW_TEMPLE_BACKGROUND\n");
	#if DRAW_SDL
	SDL_Rect rectfill = { 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT/2 };
	SDL_SetRenderDrawColor( 
		renderer, pico_palette[14][0], pico_palette[14][1], pico_palette[14][2],
		0xFF );		
	SDL_RenderFillRect( renderer, &rectfill );
	#endif
	draw_stars();
	#if DRAW_SDL
	SDL_Rect rectfill_lower = { 0, SCREEN_HEIGHT/2, SCREEN_WIDTH - 1, SCREEN_HEIGHT };
	SDL_SetRenderDrawColor( 
		renderer, pico_palette[5][0], pico_palette[5][1], pico_palette[5][2],
		0xFF );		
	SDL_RenderFillRect( renderer, &rectfill_lower );
	
	for(int i = 0; i < 3; i++){
		SDL_SetRenderDrawColor( 
			renderer, pico_palette[6][0], pico_palette[6][1], pico_palette[6][2],
			0xFF );		
		SDL_RenderDrawLine(renderer, 0, (SCREEN_HEIGHT/2 + 2) + i * 2, SCREEN_WIDTH - 1, (SCREEN_HEIGHT/2 + 2) + i * 2);
		
		SDL_SetRenderDrawColor( 
			renderer, pico_palette[15][0], pico_palette[15][1], pico_palette[15][2],
			0xFF );		
		
		SDL_RenderDrawLine(renderer, 0, (SCREEN_HEIGHT/2 - 4) - i * 2, SCREEN_WIDTH	- 1, (SCREEN_HEIGHT/2 - 4) - i * 2);
	}
	
	#endif
	printf("END_DRAW_TEMPLE_BACKGROUND\n");
}

void init_sdl(){
	#if DRAW_SDL
	if( SDL_Init ( SDL_INIT_VIDEO ) < 0) printf("shit!\n");
	window = SDL_CreateWindow("eg3d", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
	if( window == NULL ) printf("shit!\n");
	renderer = SDL_CreateRenderer( window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	if( renderer == NULL ) printf("shit!\n");
	SDL_SetRenderDrawColor( renderer, 0xFF, 0xFF, 0xFF, 0xFF );
	SDL_RenderClear( renderer );
	#endif
}

void init(){
	
	//~ init_3d();
	init_sdl();
	load_scene(&load_temple, &update_temple, &draw_temple_background);
	
}

unsigned char intersect_bounding_box( object_t * obj){
	printf("BEGIN_INTERSECT_BOUNDING_BOX\n");
	printf("ibb: %d\n", 
		((obj->min_x+obj->x < player->max_x+player->x) && (obj->max_x+obj->x > player->min_x+player->x) &&
		(obj->min_y+obj->y < player->max_y+player->y) && (obj->max_y+obj->y > player->min_y+player->y) &&
		(obj->min_z+obj->z < player->max_z+player->z) && (obj->max_z+obj->z > player->min_z+player->z))
	);
	printf("END_INTERSECT_BOUNDING_BOX\n");
	return (
		(obj->min_x+obj->x < player->max_x+player->x) && (obj->max_x+obj->x > player->min_x+player->x) &&
		(obj->min_y+obj->y < player->max_y+player->y) && (obj->max_y+obj->y > player->min_y+player->y) &&
		(obj->min_z+obj->z < player->max_z+player->z) && (obj->max_z+obj->z > player->min_z+player->z)
	);
}

void update_player(){
	printf("BEGIN_UPDATE_PLAYER\n");
	
	float old_x = player->x;
	float old_y = player->y; //UNUSED
	float old_z = player->z;
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	
	// this repeats to check per each vector, which movement to reject
	// could be optimized by passing player vars and only loop once
	player->x += player->vx;
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	
	for(int i = 0; i <= obstacle_list_used; i++){
		if(intersect_bounding_box(object_list[i])){
			player->vx = 0;
			player->x = old_x;
		}
	}
	
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	
	player->y += player->vy;
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	for(int i = 0; i < obstacle_list_used; i++){
		if(intersect_bounding_box(object_list[i])){
			player->vy = 0;
			player->y = old_y;
		}
	}
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	
	player->z += player->vz;
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	
	for(int i = 0; i <= obstacle_list_used; i++){
		if(intersect_bounding_box(object_list[i])){
			player->vz = 0;
			player->z = old_z;
		}
	}
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	player->vx *= k_friction;
	player->vy *= k_friction;
	player->vz *= k_friction;
	
	//~ printf("player.x: %f\n", player.x);
	//~ printf("player.y: %f\n", player.y);
	//~ printf("player.z: %f\n", player.z);
	printf("END_UPDATE_PLAYER\n");
}

void update_camera(){
	printf("BEGIN_UPDATE_CAMERA\n");
	cam_x = player->x;
	cam_y = player->y;
	cam_z = player->z;
	
	cam_ax = player->ax;
	cam_ay = player->ay;
	cam_az = player->az;
	
	generate_cam_matrix_transform(cam_ax, cam_ay, cam_az);
	printf("END_UPDATE_CAMERA\n");
}

void matrix_inverse(){
	printf("BEGIN_MATRIX_INVERSE\n");
	
	float det = (
		mat00* (mat11 * mat22- mat21 * mat12) -
		mat01* (mat10 * mat22- mat12 * mat20) +
		mat02* (mat10 * mat21- mat11 * mat20)
	);
	
	float invdet = 2/det;
	
	
	float o_mat00 = mat00;
	float o_mat01 = mat01;
	float o_mat02 = mat02;
	float o_mat10 = mat10;
	float o_mat11 = mat11;
	float o_mat12 = mat12;
	float o_mat20 = mat20;
	float o_mat21 = mat21;
	float o_mat22 = mat22;
	
	mat00 = (o_mat11 * o_mat22 - o_mat21 * o_mat12) * invdet;
	mat01 = (o_mat02 * o_mat21 - o_mat01 * o_mat22) * invdet;
	mat02 = (o_mat01 * o_mat12 - o_mat02 * o_mat11) * invdet;
	mat10 = (o_mat12 * o_mat20 - o_mat10 * o_mat22) * invdet;
	mat11 = (o_mat00 * o_mat22 - o_mat02 * o_mat20) * invdet;
	mat12 = (o_mat10 * o_mat02 - o_mat00 * o_mat12) * invdet;
	mat20 = (o_mat10 * o_mat21 - o_mat20 * o_mat11) * invdet;
	mat21 = (o_mat20 * o_mat01 - o_mat00 * o_mat21) * invdet;
	mat22 = (o_mat00 * o_mat11 - o_mat10 * o_mat01) * invdet;
	
	//~ printf("det: %f\n", det);
	//~ printf("invdet: %f\n", invdet);
	//~ printf("mat00: %f\n", mat00);
	//~ printf("mat01: %f\n", mat01);
	//~ printf("mat02: %f\n", mat02);
	//~ printf("mat10: %f\n", mat10);
	//~ printf("mat11: %f\n", mat11);
	//~ printf("mat12: %f\n", mat12);
	//~ printf("mat20: %f\n", mat20);
	//~ printf("mat21: %f\n", mat21);
	//~ printf("mat22: %f\n", mat22);
	
	printf("END_MATRIX_INVERSE\n");
}

void handle_input(){
	printf("BEGIN_HANDLE_INPUT\n");
	
	generate_matrix_transform(cam_ax, cam_ay, cam_az);
	matrix_inverse();
	float vx = 0;
	float vy = 0;
	float vz = 0;
	
	#if DRAW_SDL
	SDL_Event e;

	//Handle events on queue
	while( SDL_PollEvent( &e ) != 0 )
	{
		//User requests quit
		if( e.type == SDL_QUIT )
			quit = 1;
		
		//Buttons
		if( e.type == SDL_KEYDOWN ){
			switch(e.key.keysym.sym){
				case SDLK_ESCAPE:
					quit = 1;
					break;
				case SDLK_UP:
					//~ player->ax += .01;
					break;
				case SDLK_DOWN:
					//~ player->ax -= .01;
					break;
				case SDLK_LEFT:
					player->ay += -.01;
					break;
				case SDLK_RIGHT:
					player->ay += .01;
					break;
				case SDLK_w:
					rotate_point(0, 0, -.2, &vx, &vy, &vz);
					player->vx = vx;
					player->vy = vy;
					player->vz = vz;
					break;
				case SDLK_a:
					rotate_point(.2, 0, 0, &vx, &vy, &vz);
					player->vx = vx;
					player->vy = vy;
					player->vz = vz;
					break;
				case SDLK_s:
					rotate_point(0, 0, .2, &vx, &vy, &vz);
					player->vx = vx;
					player->vy = vy;
					player->vz = vz;
					break;
				case SDLK_d:
					rotate_point(-.2, 0, 0, &vx, &vy, &vz);
					player->vx = vx;
					player->vy = vy;
					player->vz = vz;
					break;
			}
		}
		
	}
	#endif
					//~ player->vx = -1 * vx;
					//~ player->vy = -1 * vy;
					//~ player->vz = -1 * vz;
					//~ printf("player.vx: %f\n", player->vx);
	
	printf("END_HANDLE_INPUT\n");
}

void update(){
	
	printf("BEGIN_UPDATE\n");
	
	for(int i = 0; i < triangle_list_used; i++)
		free(triangle_list[i]);
	triangle_list_used = 0;
	
	// INPUT HANDLING
	//~ if(btnp(4))then
		//~ scene_index+=1
		//~ if(scene_index>#scene_list)scene_index=1
		//~ load_scene(scene_list[scene_index][1],scene_list[scene_index][2],scene_list[scene_index][3])
	//~ end

	handle_input();
	
	update_player();
	update_camera();
	scene_update_func();
	
	printf("END_UPDATE\n");
}

void rotate_cam_point(float x, float y, float z, float * tx, float * ty, float * tz){
	*tx = (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20;
	  //~ (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20
	*ty = (x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21;
	  //~ (x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21
	*tz = (x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22;
	  //~ (x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22
	
	printf("BEGIN_ROTATE_CAMP\n");
	//~ printf("cam_mat00: %f\n", cam_mat00);
	//~ printf("cam_mat10: %f\n", cam_mat10);
	//~ printf("cam_mat20: %f\n", cam_mat20);
	//~ printf("cam_mat01: %f\n", cam_mat01);
	//~ printf("cam_mat11: %f\n", cam_mat11);
	//~ printf("cam_mat21: %f\n", cam_mat21);
	//~ printf("cam_mat02: %f\n", cam_mat02);
	//~ printf("cam_mat12: %f\n", cam_mat12);
	//~ printf("cam_mat22: %f\n", cam_mat22);
	
	//~ printf("x: %f\n", x);
	//~ printf("y: %f\n", y);
	//~ printf("z: %f\n", z);
	//~ printf("tx: %f\n", *tx);
	//~ printf("ty: %f\n", *ty);
	//~ printf("tz: %f\n", *tz);
	printf("END_ROTATE_CAMP\n");
	
}

void project_point(float x, float y, float z, float * sx, float * sy){
	
	printf("BEGIN_PROJECT_POINT\n");
	//~ printf("x: %f\n", x);
	//~ printf("y: %f\n", y);
	//~ printf("z: %f\n", z);
	
	//~ if ( z == 0 || x == 0 || k_screen_scale == 0 ) { 
		//~ *sx = 99999;
		//~ *sy = 99999;
	//~ } else {
		*sx = x * k_screen_scale / z + k_x_center;
		*sy = y * k_screen_scale / z + k_x_center;
	//~ }
	
	if (isnan(*sx)) { *sx = -32704; }
	if (isnan(*sy)) { *sy = -32704; }
	
	//~ printf("sx: %f\n", *sx);
	//~ printf("sz: %f\n", *sy);
	//~ printf("k_screen_scale: %d\n", k_screen_scale);
	//~ printf("k_x_center: %d\n", k_x_center);
	printf("END_PROJECT_POINT\n");
	
}

void project_radius(float radius, float tz, float * sradius){
	if(tz < 0)
		tz *= -1;
	
	*sradius = radius * k_screen_scale/tz;
	if (isinf(*sradius)) { *sradius = 32768; }
	printf("BEGIN_PR\n");
	//~ printf("sradius: %f\n", *sradius);
	//~ printf("r: %f\n", radius);
	//~ printf("z: %f\n", tz);
	//~ printf("kss: %d\n", k_screen_scale);
	printf("END_PR\n");
}

void is_visible(object_t * obj){
	
	printf ("BEGIN_IS_VIS\n");
	//~ printf ("object.tz: %f\n",(obj->tz));
	//~ printf ("object.radius: %f\n",(obj->radius));
	//~ printf ("z_max: %d\n",(z_max));
	//~ printf ("object.tz: %f\n",(obj->tz));
	//~ printf ("object.radius: %f\n",(obj->radius));
	//~ printf ("z_clip: %d\n",(z_clip));
	
	//~ printf ("object.sx: %f\n",(obj->sx));
	//~ printf ("object.sradius: %f\n",(obj->sradius));
	
	//~ printf ("object.sy: %f\n",(obj->sy));
	//~ printf ("object.sradius: %f\n",(obj->sradius));
	printf ("END_IS_VIS\n");
	
	obj->visible = (
		obj->tz + obj->radius  > z_max	&& 
		obj->tz - obj->radius  < z_clip &&
		obj->sx + obj->sradius > 0 && 
		obj->sx - obj->sradius < SCREEN_WIDTH &&
		obj->sy + obj->sradius > 0 && 
		obj->sy - obj->sradius < SCREEN_HEIGHT
	);
}

void update_visible(object_t * object){
	object->visible = 0;
	
	float px = object->x - cam_x;
	float py = object->y - cam_y;
	float pz = object->z - cam_z;
	
	printf("BEGIN_UPDATE_VIS\n");
	//~ printf("px: %f\n", px);
	//~ printf("py: %f\n", py);
	//~ printf("pz: %f\n", pz);
	//~ printf("object.x: %f\n", object->x);
	//~ printf("object.y: %f\n", object->y);
	//~ printf("object.z: %f\n", object->z);
	//~ printf("cam_x: %f\n", cam_x);
	//~ printf("cam_y: %f\n", cam_y);
	//~ printf("cam_z: %f\n", cam_z);
	
	rotate_cam_point(px, py, pz, &object->tx, &object->ty, &object->tz);
	project_point(object->tx, object->ty, object->tz, &object->sx, &object->sy);
	project_radius(object->radius, object->tz, &object->sradius);
	is_visible(object);
	
	
	printf("END_UPDATE_VIS\n");	
}

void cam_transform_object(object_t * obj){
	printf("BEGIN_CAM_TRANSFORM\n");
	if(obj->visible){
		for(int i = 0; i < obj->num_vertices; i++){
			obj->t_vertices[i][0] += (obj->x - cam_x);
			obj->t_vertices[i][1] += (obj->y - cam_y);
			obj->t_vertices[i][2] += (obj->z - cam_z);
			
			//~ printf("vertex[0]: %f\n", obj->t_vertices[i][0]);
			//~ printf("vertex[1]: %f\n", obj->t_vertices[i][1]);
			//~ printf("vertex[2]: %f\n", obj->t_vertices[i][2]);
			
			rotate_cam_point(
				obj->t_vertices[i][0],
				obj->t_vertices[i][1],
				obj->t_vertices[i][2], 
				&obj->t_vertices[i][0],
				&obj->t_vertices[i][1],
				&obj->t_vertices[i][2]
			);
			
			//~ printf("vertex[0]: %f\n", obj->t_vertices[i][0]);
			//~ printf("vertex[1]: %f\n", obj->t_vertices[i][1]);
			//~ printf("vertex[2]: %f\n", obj->t_vertices[i][2]);
		}
	}
	printf("END_CAM_TRANSFORM\n");
}

void update_light(){
	printf("BEGIN_UPDATE_LIGHT\n");
	printf("END_UPDATE_LIGHT\n");
	
	rotate_cam_point(light1_x, light1_y, light1_z, &t_light_x, &t_light_y, &t_light_z);
}

void update_3d(){
	printf("BEGIN_UPDATE_3D\n");
	for(int i = 0; i < object_list_used; i++){
		object_t * tmp_o = object_list[i];
		update_visible(tmp_o);
		transform_object(tmp_o);
		cam_transform_object(tmp_o);
		update_light();
	}
	printf("END_UPDATE_3D\n");
}

int cmp_object_list(const void * a, const void * b){
	object_t * cmp_a = *(object_t**)a;
	object_t * cmp_b = *(object_t**)b;
	
	int rc = 0;
	if ( cmp_a->tz - cmp_b->tz > 0 )
		rc = 1;
	else if ( cmp_a->tz - cmp_b->tz < 0 )
		rc = -1;
	
	return ( rc );
}

int cmp_triangle_list(const void * a, const void * b){
	triangle_t * cmp_a = *(triangle_t**)a;
	triangle_t * cmp_b = *(triangle_t**)b;
	
	int rc = 0;
	if ( cmp_a->tz - cmp_b->tz > 0 )
		rc = 1;
	else if ( cmp_a->tz - cmp_b->tz < 0 )
		rc = -1;
	
	return ( rc );
}

void three_point_sort(
	float * p1x, float * p1y, float * p1z, 
	float * p2x, float * p2y, float * p2z, 
	float * p3x, float * p3y, float * p3z){
	
	
	printf("BEGIN_TPS\n");
	
	float tmp;
	if (p1z > p2z){
		tmp = *p1z;
		*p1z = *p2z;
		*p2z = tmp;
		
		tmp = *p1x;
		*p1x = *p2x;
		*p2x = tmp;
		
		tmp = *p1y; 
		*p1y = *p2y;
		*p2y = tmp;
	}
	if (p1z > p3z){
		tmp = *p1z;
		*p1z = *p3z;
		*p3z = tmp;
		
		tmp = *p1x;
		*p1x = *p3x;
		*p3x = tmp;
		
		tmp = *p1y; 
		*p1y = *p3y;
		*p3y = tmp;
	}
	if (p2z > p3z){
		tmp = *p2z;
		*p2z = *p3z;
		*p3z = tmp;
		
		tmp = *p2x;
		*p2x = *p3x;
		*p3x = tmp;
		
		tmp = *p2y; 
		*p2y = *p3y;
		*p3y = tmp;
	}
	
	//~ printf("p1x: %f\n", *p1x);
	//~ printf("p1y: %f\n", *p1y);
	//~ printf("p1z: %f\n", *p1z);
	//~ printf("p2x: %f\n", *p2x);
	//~ printf("p2y: %f\n", *p2y);
	//~ printf("p2z: %f\n", *p2z);
	//~ printf("p3x: %f\n", *p3x);
	//~ printf("p3y: %f\n", *p3y);
	//~ printf("p3z: %f\n", *p3z);
	
	printf("END_TPS\n");
}

void z_clip_line(
	float p1x, float p1y, float p1z, float p2x, float p2y, float p2z, float clip,
	float * nx, float * ny, float * nz){
	
	printf("BEGIN_ZCL\n");
	if( p1z > p2z ){
		float tmp;
		tmp = p1x;
		p1x = p2x;
		p2x = tmp;
		
		tmp = p1z;
		p1z = p2z;
		p2z = tmp;
		
		tmp = p1y;
		p1y = p2y;
		p2y = tmp;		
	}
	
	if ( clip > p1z && clip <= p2z ){
		
		float alpha = abs((p1z-clip)/(p2z-p1z));
		
		*nx = p1x * (1.0 - alpha) + p2x * alpha;
		*ny = p1y * (1.0 - alpha) + p2y * alpha;
		*nz = p1z * (1.0 - alpha) + p2z * alpha;
	}
	printf("END_ZCL\n");
}
		
void render_object(object_t * object){
	printf("BEGIN_RENDER_OBJECT\n");
	for(int i = 0; i < object->num_vertices; i++){
		object->t_vertices[i][3] = (
			object->t_vertices[i][0] * 
			k_screen_scale 			 / 
			object->t_vertices[i][2] + 
			k_x_center
		);
		object->t_vertices[i][4] = (
			object->t_vertices[i][1] * 
			k_screen_scale 			 / 
			object->t_vertices[i][2] + 
			k_x_center
		);
		//~ printf("vertex[3]: %f\n", object->t_vertices[i][3]);
		//~ printf("vertex[4]: %f\n", object->t_vertices[i][4]);		
	}
	
	
	
	for(int i = 0; i < object->num_faces; i++){
		float * p1 = object->t_vertices[object->faces[i][0]];
		float * p2 = object->t_vertices[object->faces[i][1]];
		float * p3 = object->t_vertices[object->faces[i][2]];
		
		float p1x = p1[0];
		float p1y = p1[1];
		float p1z = p1[2];
		float p2x = p2[0];
		float p2y = p2[1];
		float p2z = p2[2];
		float p3x = p3[0];
		float p3y = p3[1];
		float p3z = p3[2];
		
		float cz = .01 * (p1z + p2z + p3z) / 3;
		float cx = .01 * (p1x + p2x + p3x) / 3;
		float cy = .01 * (p1y + p2y + p3y) / 3;
		float z_paint = (-1 * cx)*cx - cy*cy - cz*cz;
		
		//~ printf("p1x: %f\n", p1x);
		//~ printf("p1y: %f\n", p1y);
		//~ printf("p1z: %f\n", p1z);
		//~ printf("p2x: %f\n", p2x);
		//~ printf("p2y: %f\n", p2y);
		//~ printf("p2z: %f\n", p2z);
		//~ printf("p3x: %f\n", p3x);
		//~ printf("p3y: %f\n", p3y);
		//~ printf("p3z: %f\n", p3z);
		//~ printf("cx: %f\n", cx);
		//~ printf("cy: %f\n", cy);
		//~ printf("cz: %f\n", cz);
		//~ printf("z_paint: %f\n", z_paint);
		
		if(object->background == 1)
			z_paint -= 1000;
		
		object->faces[i][5] = z_paint;
		
		if( p1z > z_max || p2z > z_max || p3z > z_max ){
			if( p1z < z_clip || p2z < z_clip || p3z < z_clip ){
				float s1x = p1[3];
				float s1y = p1[4];
				float s2x = p2[3];
				float s2y = p2[4];
				float s3x = p3[3];
				float s3y = p3[4];
				//~ printf("s1x: %f\n", s1x);
				//~ printf("s1y: %f\n", s1y);
				//~ printf("s2x: %f\n", s2x);
				//~ printf("s2y: %f\n", s2y);
				//~ printf("s3x: %f\n", s3x);
				//~ printf("s3y: %f\n", s3y);
				
				if ( (s1x > 0 && s2x > 0 && s3x > 0) && (s1x < SCREEN_WIDTH && s2x < SCREEN_WIDTH && s3x < SCREEN_WIDTH) ){
					//~ printf("k0\n");
					if(( (s1x-s2x)*(s3y-s2y)-(s1y-s2y)*(s3x-s2x)) < 0){
						//~ printf("k1\n");
						if(object->color_mode==k_colorize_dynamic){
							printf("k2\n");
							p2x -= p1x;
							p2y -= p1y;
							p2z -= p1z;
							p3x -= p1x;
							p3y -= p1y;
							p3z -= p1z;
							
							//~ printf("p2x: %f\n", p2x);
							//~ printf("p2y: %f\n", p2y);
							//~ printf("p2z: %f\n", p2z);
							//~ printf("p3x: %f\n", p3x);
							//~ printf("p3y: %f\n", p3y);
							//~ printf("p3z: %f\n", p3z);
							
							float nx = p2y * p3z - p2z * p3y;
							float ny = p2z * p3x - p2x * p3z;
							float nz = p2x * p3y - p2y * p3x;
							
							nx *= 4;
							ny *= 4;
							nz *= 4;
							
							//~ printf("nx: %f\n", nx);
							//~ printf("ny: %f\n", ny);
							//~ printf("nz: %f\n", nz);
							
							float inv_dist = 1 / sqrt(nx * nx + ny * ny + nz * nz);
							nx *= inv_dist;
							ny *= inv_dist;
							nz *= inv_dist;
							
							float mid, b;
							b = nx*t_light_x+ny*t_light_y+nz*t_light_z;
							if ( b <= 0 ) mid = 0 + k_ambient;
							else if ( b >= 1) mid = (1-k_ambient) + k_ambient;
							else mid = b * (1-k_ambient) + k_ambient;
							
							//~ color_shade(object->faces[i][4], mid, &object->faces[i][4], &object->faces[i][5]);
							color_shade(object->color, mid, &object->faces[i][3], &object->faces[i][4]);
							
						}
						
						new_triangle(s1x, s1y, s2x, s2y, s3x, s3y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);						
					}
				}
			} else if (p1z < z_clip || p2z < z_clip || p3z < z_clip) {
				three_point_sort(&p1x, &p1y, &p1z, &p2x, &p2y, &p2z, &p3x, &p3y, &p3z);
				
			
				if(p1z < z_clip && p2z < z_clip){
					
					float n2x, n2y, n2z = 0;
					z_clip_line(p2x, p2y, p2z, p3z, p3y, p3z, z_clip,
						&n2x, &n2y, &n2z);
					
					float n3x, n3y, n3z = 0;
					z_clip_line(p3x, p3y, p3z, p1z, p1y, p1z, z_clip,
						&n3x, &n3y, &n3z);
					
					float s1x, s1y = 0;
					project_point(p1x, p1y, p1z, &s1x, &s1y);
					float s2x, s2y = 0;
					project_point(p2x, p2y, p2z, &s2x, &s2y);
					float s3x, s3y = 0;
					project_point(n2x, n2y, n2z, &s3x, &s3y);
					float s4x, s4y = 0;
					project_point(n3x, n3y, n3z, &s4x, &s4y);
					
					if( (s1x > 0 && s2x > 0 && s4x > 0) &&
						(s4x < SCREEN_WIDTH && s4x < SCREEN_WIDTH && s4x < SCREEN_WIDTH)){
						
						new_triangle(s1x, s1y, s2x, s2y, s4x, s4y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);
						
					}
					
					if( (s2x > 0 && s3x > 0 && s4x > 0) &&
						(s2x < SCREEN_WIDTH && s3x < SCREEN_WIDTH && s4x < SCREEN_WIDTH)){
						
						new_triangle(s2x, s2y, s4x, s4y, s3x, s3y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);
						
					}
					
					
				} else {
					
					float n1x, n1y, n1z = 0;
					z_clip_line(p1x, p1y, p1z, p2x, p2y, p2z, z_clip,
						&n1x, &n1y, &n1z);
					
					float n2x, n2y, n2z = 0;
					z_clip_line(p1x, p1y, p1z, p3x, p3y, p3z, z_clip,
						&n2x, &n2y, &n2z);
					
					float s1x, s1y = 0;
					project_point(p1x, p1y, p1z, &s1x, &s1y);
					float s2x, s2y = 0;
					project_point(n1x, n1y, n1z, &s2x, &s2y);
					float s3x, s3y = 0;
					project_point(n2x, n2y, n2z, &s3x, &s3y);
					
					
					if( (s1x > 0 && s2x > 0 && s3x > 0) &&
						(s1x < SCREEN_WIDTH && s2x < SCREEN_WIDTH && s3x < SCREEN_WIDTH)){
						
						new_triangle(s1x, s1y, s2x, s2y, s3x, s3y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);
						
					}
					
				}
			}
		}
	}	
	printf("END_RENDER_OBJECT\n");
}

void shade_trifill(triangle_t * tri){
	printf("BEGIN_SHADE_TRIFILL\n");
	//hell, are these supposed to be ints?
		
	float x1 = tri->p1x;	
	float x2 = tri->p2x;
	float x3 = tri->p3x;
	int y1 = rintf(tri->p1y);
	int y2 = rintf(tri->p2y);
	int y3 = rintf(tri->p3y);
	
	//~ printf("x1: %d\n", x1);
	//~ printf("x2: %d\n", x2);
	//~ printf("x3: %d\n", x3);
	//~ printf("y1: %d\n", y1);
	//~ printf("y2: %d\n", y2);
	//~ printf("y3: %d\n", y3);
	
	float tmp = 0;
	
	if(y1 > y2){
		tmp = y1;
		y1 = y2;
		y2 = tmp;
		
		tmp = x1;
		x1 = x2;
		x2 = tmp;
	}
	
	if(y1 > y3){
		tmp = y1;
		y1 = y3;
		y3 = tmp;
		
		tmp = x1;
		x1 = x3;
		x3 = tmp;
	}
	
	if(y2 > y3){
		tmp = y2;
		y2 = y3;
		y3 = tmp;
		
		tmp = x2;
		x2 = x3;
		x3 = tmp;
	}
	
	float nsx = 0;
	float nex = 0; 
	int min_y = 0;
	int max_y = 0;
	
	if( y1 != y2 ){
		//~ printf("y1 != y2\n");
		float delta_sx = (x3 - x1)/(y3 - y1);
		float delta_ex = (x2 - x1)/(y2 - y1);
				
		if(y1 > 0){
		//~ printf("y1 > 0\n");
			nsx = x1;
			nex = x1;
			min_y = y1;
		} else {
		//~ printf("y1 > 0 -- else\n");
			//top edge clip
			nsx = x1 - delta_sx * y1;
			nex = x1 - delta_ex * y1;
			min_y = 0;
		}
		
		max_y = MIN(y2, SCREEN_WIDTH);
		//~ printf("min_y: %d\n", min_y);
		//~ printf("max_y: %d\n", max_y);
		//~ printf("nsx:   %f\n", nsx);
		//~ printf("nex:   %f\n", nsx);
		
		for(int i = min_y; i < max_y; i++){
			//~ printf("i: %d\n", i);
			
			if ( (i & 1) == 0 ){
				//~ printf("(i & 1): %d\n", (i & 1));	
				#if DRAW_SDL		
				
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c1][0], pico_palette[tri->c1][1], pico_palette[tri->c1][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), i, rintf(nex), i);
				#endif
			} else {
				//~ printf("else (i & 1): %d\n", (i & 1));
				#if DRAW_SDL
				
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c2][0], pico_palette[tri->c2][1], pico_palette[tri->c2][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), i, rintf(nex), i);
				#endif
			}
			
			nsx += delta_sx;
			nex += delta_ex;
		}
		
	} else {
		//top edge is horizontal
		nsx = x1;
		nex = x2;
	}
	
	if(y3 != y2){
		//~ printf("(y3 != y2)\n");
		float delta_sx = (x3 - x1) / (y3 - y1);
		float delta_ex = (x3 - x2) / (y3 - y2);
		
		min_y = y2;
		max_y = MIN(y3,SCREEN_HEIGHT);
		
		if(y2 < 0){
			//~ printf("y2 < 0\n");
			nex = x2 - delta_ex * y2;
			nsx = x1 - delta_sx * y1;
			min_y = 0;
		}
		
		for(int i = min_y; i < max_y; i++){
			
			if ( (i & 1) == 0 ){
				//~ printf("(i & 1)\n");
				
				#if DRAW_SDL
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c1][0], pico_palette[tri->c1][1], pico_palette[tri->c1][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), i, rintf(nex), i);
				#endif
			} else {
				//~ printf("else (i & 1): %d\n", (i & 1));
				
				#if DRAW_SDL
				
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c2][0], pico_palette[tri->c2][1], pico_palette[tri->c2][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), i, rintf(nex), i);
				#endif
			}
			
			nsx += delta_sx;
			nex += delta_ex;
		}
		
	} else {
		//~ printf("else (y3 != y2)\n");
		//where bottom edge is horizontal???
		if ( ( ((int)rintf(y3)) & 1) == 0 ){
				//~ printf("(i & 1)\n");
				
				#if DRAW_SDL
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c1][0], pico_palette[tri->c1][1], pico_palette[tri->c1][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), y3, rintf(nex), y3);
				#endif
			} else {
				//~ printf("else (i & 1): %d\n", (y3 & 1));
				
				#if DRAW_SDL
				SDL_SetRenderDrawColor( 
					renderer, pico_palette[tri->c2][0], pico_palette[tri->c2][1], pico_palette[tri->c2][2], 
					0xFF );
				SDL_RenderDrawLine(renderer, rintf(nsx), y3, rintf(nex), y3);
				#endif
		}
	}
	
	printf("END_SHADE_TRIFILL\n");
}

void draw_triangle_list(){
	printf("BEGIN_DRAW_TRIANGLE_LIST\n");
	
	for(int i = 0; i < triangle_list_used; i++){
		shade_trifill(triangle_list[i]);
	}
	printf("END_DRAW_TRIANGLE_LIST\n");
}

void draw_3d(){
	printf("BEGIN_DRAW_3D\n");
	
	for(int i = 0; i < triangle_list_used; i++){
		free(triangle_list[i]);
		triangle_list_used = 0;
	}
	
	//~ quicksort_object_list(0, object_list_used);
	qsort(object_list, object_list_used, sizeof(object_t*), cmp_object_list);
	
	for(int i = 0; i < object_list_used; i++){
		if( object_list[i]->visible == 1 &&
			object_list[i]->background != 1){
			render_object( object_list[i] );
		}
	}
	
	//~ quicksort_triangle_list(0, triangle_list_used);
	qsort(triangle_list, triangle_list_used, sizeof(triangle_t*), cmp_triangle_list);
	
	draw_triangle_list();
	
	printf("END_DRAW_3D\n");
}

void draw(){
	printf("BEGIN_DRAW\n");
	
	cur_frame += 1;
	scene_background_func();
	
	update_3d();
	
	draw_3d();
	
	printf("END_DRAW\n");
}

void cleanup(){

	
	for(int i = 0; i < object_list_used; i++){
		//free the verts
		if (object_list[i]->vertices != NULL){
			for(int j = 0; j < object_list[i]->num_vertices; j++)
				free(object_list[i]->vertices[j]);
			free(object_list[i]->vertices);
		}
		//free the t_verts
		if (object_list[i]->t_vertices != NULL){
			for(int j = 0; j < object_list[i]->num_vertices; j++)
				free(object_list[i]->t_vertices[j]);
			free(object_list[i]->t_vertices);
		}
		//free the faces
		if (object_list[i]->faces != NULL){
			for(int j = 0; j < object_list[i]->num_faces; j++)
				free(object_list[i]->faces[j]);
			free(object_list[i]->faces);
		}
		//free the base_faces
		if (object_list[i]->base_faces != NULL){
			for(int j = 0; j < object_list[i]->num_faces; j++)
				free(object_list[i]->base_faces[j]);
			free(object_list[i]->base_faces);
		}
	}
	
	for(int i = 0; i < object_list_used; i++)
		free(object_list[i]);
	
	if(object_list != NULL) free(object_list);
	
	if(obstacle_list != NULL) free(obstacle_list);
	
	for(int i = 0; i < triangle_list_used; i++)
		free(triangle_list[i]);
	if(triangle_list != NULL) free(triangle_list);

	#if DRAW_SDL
	SDL_DestroyRenderer( renderer );
	SDL_DestroyWindow( window );
	SDL_Quit();
	#endif

}

int main(){
	
	srand(time(NULL));
	
	init();
	
	#if DRAW_SDL
	SDL_SetRenderDrawColor( renderer, 0xFF, 0xFF, 0xFF, 0xFF );
	SDL_RenderClear( renderer );
	
	while (!quit){
		SDL_SetRenderDrawColor( renderer, 0xFF, 0xFF, 0xFF, 0xFF );
		SDL_RenderClear( renderer );
	#endif
		update();
		draw();
	#if DRAW_SDL
		SDL_RenderPresent( renderer );
	}
	#endif
	
	cleanup();
	
	return 0;
}
