#include <stdio.h>
#include <math.h>
#include <time.h>

#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>

SDL_Window * window = NULL;
SDL_Renderer * renderer = NULL;
int SCREEN_WIDTH = 128;
int SCREEN_HEIGHT = 128;
int k_x_center = 64;
int k_y_center = 64;

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
int k_color1 = 4;
int k_color2 = 5;
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
float cam_mat00 = 0;
float cam_mat10 = 0;
float cam_mat20 = 0;
float cam_mat01 = 0;
float cam_mat11 = 0;
float cam_mat21 = 0;
float cam_mat02 = 0;
float cam_mat12 = 0;
float cam_mat22 = 0;

unsigned  double_color_list[32][10] = {
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
	{ 0x02, 0x03, 0x04 },
	{ 0x01, 0x03, 0x02 },
	{ 0x04, 0x03, 0x01 },
	{ 0x01, 0x02, 0x04 }
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
	{ 0x06, 0x02, 0x01 },
	{ 0x07, 0x03, 0x02 },
	{ 0x08, 0x04, 0x03 },
	{ 0x05, 0x01, 0x04 },
	{ 0x05, 0x08, 0x0c },
	{ 0x10, 0x0d, 0x0c },
	{ 0x08, 0x07, 0x0b },
	{ 0x07, 0x06, 0x0a },
	{ 0x06, 0x05, 0x09 },
	{ 0x10, 0x14, 0x11 },
	{ 0x0f, 0x10, 0x0b },
	{ 0x0e, 0x0f, 0x0a },
	{ 0x0d, 0x0e, 0x09 },
	{ 0x0f, 0x13, 0x14 },
	{ 0x0e, 0x12, 0x13 },
	{ 0x0d, 0x11, 0x12 },
	{ 0x0d, 0x09, 0x0c },
	{ 0x10, 0x0c, 0x0b },
	{ 0x0f, 0x0b, 0x0a },
	{ 0x0e, 0x0a, 0x09 },
	{ 0x05, 0x06, 0x01 },
	{ 0x06, 0x07, 0x02 },
	{ 0x07, 0x08, 0x03 },
	{ 0x08, 0x05, 0x04 },
	{ 0x09, 0x05, 0x0c },
	{ 0x0c, 0x08, 0x0b },
	{ 0x0b, 0x07, 0x0a },
	{ 0x0a, 0x06, 0x09 },
	{ 0x0d, 0x10, 0x11 },
	{ 0x10, 0x0f, 0x14 },
	{ 0x0f, 0x0e, 0x13 },
	{ 0x0e, 0x0d, 0x12 }
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
	{ 0x03, 0x04, 0x10 },
	{ 0x07, 0x0b, 0x0c },
	{ 0x01, 0x05, 0x06 },
	{ 0x02, 0x06, 0x07 },
	{ 0x07, 0x08, 0x04 },
	{ 0x01, 0x04, 0x08 },
	{ 0x0b, 0x0a, 0x0e },
	{ 0x06, 0x0a, 0x0b },
	{ 0x08, 0x0c, 0x09 },
	{ 0x05, 0x09, 0x0a },
	{ 0x09, 0x0d, 0x0e },
	{ 0x03, 0x0f, 0x0e },
	{ 0x01, 0x0d, 0x10 },
	{ 0x02, 0x0e, 0x0d },
	{ 0x10, 0x0d, 0x09 },
	{ 0x0b, 0x0f, 0x10 },
	{ 0x0f, 0x03, 0x10 },
	{ 0x08, 0x07, 0x0c },
	{ 0x02, 0x01, 0x06 },
	{ 0x03, 0x02, 0x07 },
	{ 0x03, 0x07, 0x04 },
	{ 0x05, 0x01, 0x08 },
	{ 0x0f, 0x0b, 0x0e },
	{ 0x07, 0x06, 0x0b },
	{ 0x05, 0x08, 0x09 },
	{ 0x06, 0x05, 0x0a },
	{ 0x0a, 0x09, 0x0e },
	{ 0x02, 0x03, 0x0e },
	{ 0x04, 0x01, 0x10 },
	{ 0x01, 0x02, 0x0d },
	{ 0x0c, 0x10, 0x09 },
	{ 0x0c, 0x0b, 0x10 }
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
	{ 0x02, 0x04, 0x03 },
	{ 0x04, 0x06, 0x05 },
	{ 0x06, 0x08, 0x07 },
	{ 0x0a, 0x0f, 0x0b },
	{ 0x0a, 0x02, 0x01 },
	{ 0x08, 0x0a, 0x09 },
	{ 0x01, 0x15, 0x19 },
	{ 0x0f, 0x14, 0x10 },
	{ 0x08, 0x0e, 0x0f },
	{ 0x06, 0x0d, 0x0e },
	{ 0x04, 0x0c, 0x0d },
	{ 0x02, 0x0b, 0x0c },
	{ 0x11, 0x10, 0x14 },
	{ 0x0e, 0x13, 0x14 },
	{ 0x0d, 0x12, 0x13 },
	{ 0x0c, 0x11, 0x12 },
	{ 0x0b, 0x10, 0x11 },
	{ 0x09, 0x19, 0x18 },
	{ 0x05, 0x07, 0x18 },
	{ 0x03, 0x05, 0x17 },
	{ 0x03, 0x16, 0x15 },
	{ 0x01, 0x02, 0x03 },
	{ 0x03, 0x04, 0x05 },
	{ 0x05, 0x06, 0x07 },
	{ 0x02, 0x0a, 0x0b },
	{ 0x09, 0x0a, 0x01 },
	{ 0x07, 0x08, 0x09 },
	{ 0x09, 0x01, 0x19 },
	{ 0x0b, 0x0f, 0x10 },
	{ 0x0a, 0x08, 0x0f },
	{ 0x08, 0x06, 0x0e },
	{ 0x06, 0x04, 0x0d },
	{ 0x04, 0x02, 0x0c },
	{ 0x13, 0x12, 0x11 },
	{ 0x13, 0x11, 0x14 },
	{ 0x0e, 0x0d, 0x13 },
	{ 0x0f, 0x0e, 0x14 },
	{ 0x0d, 0x0c, 0x12 },
	{ 0x0c, 0x0b, 0x11 },
	{ 0x07, 0x09, 0x18 },
	{ 0x17, 0x05, 0x18 },
	{ 0x16, 0x03, 0x17 },
	{ 0x01, 0x03, 0x15 }
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
	float ax;
	float ay;
	float az;
	float vx;
	float vy;
	float vz;
} player_t;
player_t player;

typedef struct {
	void *fake;
} particle_list_t;

typedef struct {
	unsigned short x;
	unsigned short y;
} star_t;
star_t star_list[150];

typedef struct {
	float (*vertices)[3];
	unsigned char (*base_faces)[3];
	unsigned char (*faces)[3];
	float (*t_vertices)[5];
	int num_vertices;
	int num_faces;
	int x;
	int y;
	int z;
	int rx;
	int ry;
	int rz;
	float tx;
	float ty;
	float tz;
	int ax;
	int ay;
	int az;
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

triangle_t * triangle_list = NULL;
int triangle_list_used = 0;
int triangle_list_length = 0;

object_t * object_list = NULL;
int object_list_used = 0;
int object_list_length = 0;

object_t * obstacle_list = NULL;
int obstacle_list_used = 0;
int obstacle_list_length = 0;

object_t * hole = NULL;
object_t * pyramids[5] = { NULL };

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
	player.ax = 0;
	player.ay = 0;
	player.az = 0;
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
	
	if (object_list != NULL){
		for(int i = 0; i < object_list_used; i++){
			for(int j = 0; j < (object_list + i)->num_vertices; j++){
				free((object_list + i)->vertices);
				free((object_list + i)->t_vertices);
			}
			for(int j = 0; j < (object_list + i)->num_faces; j++){
				free((object_list + i)->faces);
				free((object_list + i)->base_faces);
			}
		}
		object_list_used = 0;
		object_list = NULL;
	}
	
	particle_list_t p_l = { .fake = NULL };
	
}

void load_scene(void (*init_func)(), void (*update_func)(), void (*background_func)()){
	scene_update_func = update_func;
	scene_background_func = background_func;
	init_3d();
	init_func();
}

void init_stars(){
	for(int i = 0; i < 150; i++){
		star_list[i].x = rand() % 508;
		star_list[i].y = rand() % 55;
	}
}

void add_object_to_list(object_t * new_obj){
	
	if (object_list_used == object_list_length){
		object_list_length += 2;
		object_list = realloc(object_list, (sizeof(object_t)) * object_list_length);
	}
	
	// pointer of object_list[index] is now new_object's pointer
	*(object_list + object_list_used) = *new_obj;
	
	object_list_used++;
}

void del_object_from_list(int i){
	object_list[i] = object_list[object_list_used -1];
	object_list_used--;
}

void add_obstacle_to_list(object_t * new_obj){
	
	if (obstacle_list_used == obstacle_list_length){
		obstacle_list_length += 2;
		obstacle_list = realloc(obstacle_list, (sizeof(object_t)) * obstacle_list_length);
	}
	
	*(obstacle_list + obstacle_list_used) = *new_obj;
	
	obstacle_list_used++;
}

void del_obstacle_from_list(int i){
	obstacle_list[i] = obstacle_list[obstacle_list_used -1];
	obstacle_list_used--;
}



void add_triangle_to_list(triangle_t * new_tri){
	
	if (triangle_list_used == triangle_list_length){
		triangle_list_length += 2;
		triangle_list = realloc(triangle_list, (sizeof(triangle_t)) * triangle_list_length);
	}
	
	// pointer of triangle_list[index] is now new_triangle's pointer
	*(triangle_list + triangle_list_used) = *new_tri;
	
	triangle_list_used++;
}

void del_triangle_from_list(int i){
	triangle_list[i] = triangle_list[triangle_list_used -1];
	triangle_list_used--;
}

object_t * new_object(){
	object_t * obj = malloc(sizeof (object_t));
	
	obj->vertices = NULL;
	obj->base_faces = NULL;
	obj->faces = NULL;
	obj->t_vertices = NULL;
	obj->num_faces = 0;
	obj->num_vertices = 0;
	obj->x = 0;
	obj->y = 0;
	obj->z = 0;
	obj->rx = 0;
	obj->ry = 0;
	obj->rz = 0;
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
	
	add_object_to_list(obj);
	
	return obj;
}

triangle_t * new_triangle(
	float p1x, float p1y, float p2x, float p2y, float p3x, float p3y,
	float tz, int c1, int c2
	){
	
	triangle_t * tri = malloc(sizeof (triangle_t));
	
	tri->p1x = p1x;
	tri->p1y = p1y;
	tri->p2x = p2x;
	tri->p2y = p2y;
	tri->p3x = p3x;
	tri->p3y = p3y;
	tri->tz = tz;
	tri->c1 = c1;
	tri->c2 = c2;
	
	add_triangle_to_list(tri);
	
	return tri;
}

void generate_matrix_transform(int xa, int ya, int za){

	int sx=sin(xa);
	int sy=sin(ya);
	int sz=sin(za);
	int cx=cos(xa);
	int cy=cos(ya);
	int cz=cos(za);
	
	mat00=cz*cy;
	mat10=-sz;
	mat20=cz*sy;
	mat01=cx*sz*cy+sx*sy;
	mat11=cx*cz;
	mat21=cx*sz*sy-sx*cy;
	mat02=sx*sz*cy-cx*sy;
	mat12=sx*cz;
	mat22=sx*sz*sy+cx*cy;

}

void generate_cam_matrix_transform(int xa, int ya, int za){

	int sx=sin(xa);
	int sy=sin(ya);
	int sz=sin(za);
	int cx=cos(xa);
	int cy=cos(ya);
	int cz=cos(za);
	
	cam_mat00=cz*cy;
	cam_mat10=-sz;
	cam_mat20=cz*sy;
	cam_mat01=cx*sz*cy+sx*sy;
	cam_mat11=cx*cz;
	cam_mat21=cx*sz*sy-sx*cy;
	cam_mat02=sx*sz*cy-cx*sy;
	cam_mat12=sx*cz;
	cam_mat22=sx*sz*sy+cx*cy;

}

void rotate_point(float (*v)[3], float (*t)[5]){
	*t[0] = ((float)*v[0] * mat00 + (float)*v[1] *mat10 + (float)*v[2] * mat20);
	*t[1] = ((float)*v[0] * mat01 + (float)*v[1] *mat11 + (float)*v[2] * mat21);
	*t[2] = ((float)*v[0] * mat02 + (float)*v[1] *mat12 + (float)*v[2] * mat22);
}

void transform_object(object_t * object){
	//shouldn't this not be happening if all the axes are 0?
	if(object->visible){
		generate_matrix_transform(object->ax, object->ay, object->az);
		for(int i = 0; i < object->num_vertices; i++){
			//pass direct access to objects verts
			rotate_point(&object->vertices[i], &object->t_vertices[i]);
		}
	}
}

void set_radius(object_t * object){
	
	for(int i = 0; i < object->num_vertices; i++){
		int max_test = 
			object->vertices[i][1] * object->vertices[i][1] + 
			object->vertices[i][2] * object->vertices[i][2] + 
			object->vertices[i][3] * object->vertices[i][3];
			
		if( max_test > object->radius)
			object->radius = max_test;
	}
	object->radius=sqrt(object->radius);
	
}

void set_bounding_box(object_t * object){
	
	for(int i = 0; i < object->num_vertices; i++){
		if( object->min_x > object->vertices[i][1] )
			object->min_x = object->vertices[i][1];
		if( object->min_y > object->vertices[i][2] )
			object->min_y = object->vertices[i][2];
		if( object->min_z > object->vertices[i][3] )
			object->min_z = object->vertices[i][3];
		
		if( object->max_x < object->vertices[i][1] )
			object->max_x = object->vertices[i][1];
		if( object->max_y < object->vertices[i][2] )
			object->max_y = object->vertices[i][2];
		if( object->max_z < object->vertices[i][3] )
			object->max_z = object->vertices[i][3];
	}

}

void vector_cross_3d(
	float px, float py, float pz,
	float ax, float ay, float az,
	float bx, float by, float bz,
	float * nx, float * ny, float * nz){
	
	ax = px * -1;
	ay = py * -1;
	az = pz * -1;
	bx = px * -1;
	by = py * -1;
	bz = pz * -1;
	
	*nx = ay * bz - az * by;
	*ny = az * bx - ax * bz;
	*nz = ax * by - ay * bx;
}

float vector_dot_3d(float ax, float ay, float az, float bx, float by, float bz){
	return (ax * bx + ay * by + az * bz);
}

void color_shade(unsigned char color, float brightness, unsigned char * f4, unsigned char * f5){
	int b = (int)(brightness*10) & 0xffff;
	unsigned char c = (color + 1) * 2;
	*f4 = double_color_list[c - 1][b];
	*f5 = double_color_list[c][b];
}

void color_faces(object_t * object){
	
	for(int i = 0; i < object->num_faces; i++){
		unsigned char * face = object->faces[i];
		float p1x = object->t_vertices[face[1]][1];
		float p1y = object->t_vertices[face[1]][2];
		float p1z = object->t_vertices[face[1]][3];
		float p2x = object->t_vertices[face[2]][1];
		float p2y = object->t_vertices[face[2]][2];
		float p2z = object->t_vertices[face[2]][3];
		float p3x = object->t_vertices[face[3]][1];
		float p3y = object->t_vertices[face[3]][2];
		float p3z = object->t_vertices[face[3]][3];
		
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
			color_shade(object->base_faces[i][4], mid, &face[4], &face[5]);
		} else {
			color_shade(object->color, mid, &face[4], &face[5]);			
		}
		
	}
	
}

object_t * load_object(
	float (*object_vertices)[3], unsigned short num_vertices,
	unsigned char (*object_faces)[3], unsigned short num_faces,
	int x, int y, int z, int ax, int ay, int az,
	int obstacle, int color_mode, int color){
	
	object_t * object = new_object();
	
	//copy verts
	object->vertices = malloc(sizeof (float[3]) * num_vertices);
	for(int i = 0; i < num_vertices; i++)
		for(int j = 0; j < 3; j++)
			object->vertices[i][j] = object_vertices[i][j];
	
	//copy for translated verts
	object->t_vertices = malloc(sizeof (float[3]) * num_vertices);
	for(int i = 0; i < num_vertices; i++)
		for(int j = 0; j < 3; j++)
			object->t_vertices[i][j] = object_vertices[i][j];
	
	//copy faces
	object->faces = malloc(sizeof (unsigned char[3]) * num_faces);
	for(int i = 0; i < num_faces; i++)
		for(int j = 0; j < 3; j++)
			object->faces[i][j] = object_faces[i][j];
	
	//base faces for shading
	if (color_mode != k_preset_color){
		object->base_faces = malloc(sizeof (unsigned char[3]) * num_faces);
		for(int i = 0; i < num_faces; i++)
			for(int j = 0; j < 3; j++)
				object->base_faces[i][j] = object_faces[i][j];
	}
	
	//move everything above into new_object, and pass it all this shit^^
	
	object->radius = 0;
	object->ax = ax;
	object->ay = ay;
	object->az = az;
	object->num_vertices = num_vertices;
	object->num_faces = num_faces;
	
	transform_object(object);
	set_radius(object);
	set_bounding_box(object);
	
	object->x = x;
	object->y = y;
	object->z = z;
	
	object->color = color;
	object->color_mode = color_mode;
	object->obstacle = obstacle;
	
	if(obstacle)
		add_obstacle_to_list(object);
	
	if ( color_mode==k_colorize_static || 
		color_mode==k_colorize_dynamic || 
		color_mode==k_multi_color_static ){
		color_faces(object);
	}
	
	return object;
}

void load_temple(){
	
	init_stars();
	
	// create 5 columns
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
	
	//load fountain
	load_object(
		fountain_v_string,
		(sizeof(fountain_v_string)/sizeof(float)),
		fountain_f_string,
		(sizeof(fountain_f_string)/sizeof(char)),
		0,0,0,0,.08,0,1,k_colorize_static,14
	);
	
	//load hole
	hole = load_object(
		hole_v_string,
		(sizeof(hole_v_string)/sizeof(float)),
		hole_f_string,
		(sizeof(hole_f_string)/sizeof(char)),
		0,11,0,.125,.125,.125,0,k_colorize_dynamic,12
	);
	
	// create 5 pyramids
	for(int i = 0; i < 5; i++){
		unsigned char l = 25;
		float a = i/5+.125;
		unsigned char x = sin(a)*l;
		unsigned char z = cos(a)*l;
		pyramids[i] = load_object(
			pyramid_v_string,
			(sizeof(pyramid_v_string)/sizeof(float)),
			pyramid_f_string,
			(sizeof(pyramid_f_string)/sizeof(char)),
			x, 0, z, 0, 0, 0, 0, k_colorize_static, 13
		);
	}
	
}

void update_temple(){}
void draw_temple_background(){}

void init_sdl(){
	
	SDL_Init ( SDL_INIT_VIDEO );
	window = SDL_CreateWindow("eg3d", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
	renderer = SDL_CreateRenderer( window, -1, SDL_RENDERER_ACCELERATED );
	SDL_SetRenderDrawColor( renderer, 0xFF, 0xFF, 0xFF, 0xFF );
	SDL_RenderClear( renderer );
	
}

void init(){
	
	init_3d();
	init_sdl();
	load_scene(&load_temple, &update_temple, &draw_temple_background);
	
}

unsigned char intersect_bounding_box( object_t * obj){
	return (
		(obj->min_x+obj->x < player.max_x+player.x) && (obj->max_x+obj->x > player.min_x+player.x) &&
		(obj->min_y+obj->y < player.max_y+player.y) && (obj->max_y+obj->y > player.min_y+player.y) &&
		(obj->min_z+obj->z < player.max_z+player.z) && (obj->max_z+obj->z > player.min_z+player.z)
	);
}

void update_player(){
	float old_x = player.x;
	float old_y = player.y;
	float old_z = player.z;
	
	// this repeats to check per each vector, which movement to reject
	// could be optimized by passing player vars and only loop once
	player.x += player.vx;	
	for(int i = 0; i < obstacle_list_used; i++){
		if(intersect_bounding_box((object_list + i))){
			player.vx = 0;
			player.x = old_x;
		}
	}
	
	player.y += player.vy;
	for(int i = 0; i < obstacle_list_used; i++){
		if(intersect_bounding_box((object_list + i))){
			player.vy = 0;
			player.y = old_y;
		}
	}
	
	player.z += player.vz;
	for(int i = 0; i < obstacle_list_used; i++){
		if(intersect_bounding_box((object_list + i))){
			player.vz = 0;
			player.z = old_z;
		}
	}
	
	player.vx *= k_friction;
	player.vy *= k_friction;
	player.vz *= k_friction;
	
}

void update_camera(){
	float cam_x = player.x;
	float cam_y = player.y;
	float cam_z = player.z;
	
	float cam_ax = player.ax;
	float cam_ay = player.ay;
	float cam_az = player.az;
	
	generate_cam_matrix_transform(cam_ax, cam_ay, cam_az);
}

void update(){
	
	// INPUT HANDLING
	//~ if(btnp(4))then
		//~ scene_index+=1
		//~ if(scene_index>#scene_list)scene_index=1
		//~ load_scene(scene_list[scene_index][1],scene_list[scene_index][2],scene_list[scene_index][3])
	//~ end

	//~ handle_buttons() -- handle default buttons for player-- this can be overwritten obviously.
	
	update_player();
	update_camera();
	scene_update_func();
	
}

void rotate_cam_point(float x, float y, float z, float * tx, float * ty, float * tz){
	
	*tx = (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20;
	*ty = (x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21;
	*tz = (x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22;
	
}

void project_point(int x, int y, int z, float * sx, float * sy){
	
	*sx = x * k_screen_scale / z + k_x_center;
	*sy = y * k_screen_scale / z + k_x_center;
	
}

void project_radius(float radius, float tz, float * sradius){	
	*sradius = radius * k_screen_scale/abs(tz);
}

void is_visible(object_t * obj){
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
	
	rotate_cam_point(px, py, pz, &object->tx, &object->ty, &object->tz);
	project_point(object->tx, object->ty, object->tz, &object->sx, &object->sy);
	project_radius(object->radius, object->tz, &object->sradius);
	is_visible(object);
	
}

void cam_transform_object(object_t * obj){
	if(obj->visible){
		for(int i = 0; i < obj->num_vertices; i++){
			obj->t_vertices[i][0] + (obj->x - cam_x);
			obj->t_vertices[i][1] + (obj->x - cam_x);
			obj->t_vertices[i][2] + (obj->x - cam_x);
			
			rotate_cam_point(
				obj->t_vertices[i][0],
				obj->t_vertices[i][1],
				obj->t_vertices[i][2], 
				&obj->tx,
				&obj->ty,
				&obj->tz
			);
		}
	}
}

void update_light(){
	rotate_cam_point(light1_x, light1_y, light1_z, &t_light_x, &t_light_y, &t_light_z);
}

void update_3d(){
	
	for(int i = 0; i < object_list_used; i++){
		object_t * tmp_o = (object_list+i);
		update_visible(tmp_o);
		transform_object(tmp_o);
		cam_transform_object(tmp_o);
		update_light();
	}
}

void quicksort_object_list(int start, int end){
	if((end - start) < 1)
		return;
	
	int pivot = start;
	for(int i = start + 1; i < end; i++){
		if((object_list + i)->tz <= (object_list + pivot)->tz){
			if(i == pivot + 1){
				object_t * tmp = (object_list + pivot);
				*(object_list + pivot) = *(object_list + pivot + 1);
				*(object_list + pivot + 1) = *tmp;
			} else {
				object_t * tmp = (object_list + pivot);
				object_t * tmp_plus_1 = (object_list + pivot + 1);
				*(object_list + pivot) = *(object_list + i);
				*(object_list + pivot + 1) = *tmp;
				*(object_list + i) = *tmp_plus_1;
			}
			pivot++;
		}
	}
	quicksort_object_list(start, pivot - 1);
	quicksort_object_list(pivot + 1, end);	
}

void quicksort_triangle_list(int start, int end){
	if((end - start) < 1)
		return;
	
	int pivot = start;
	for(int i = start + 1; i < end; i++){
		if((triangle_list + i)->tz <= (triangle_list + pivot)->tz){
			if(i == pivot + 1){
				triangle_t * tmp = (triangle_list + pivot);
				*(triangle_list + pivot) = *(triangle_list + pivot + 1);
				*(triangle_list + pivot + 1) = *tmp;
			} else {
				triangle_t * tmp = (triangle_list + pivot);
				triangle_t * tmp_plus_1 = (triangle_list + pivot + 1);
				*(triangle_list + pivot) = *(triangle_list + i);
				*(triangle_list + pivot + 1) = *tmp;
				*(triangle_list + i) = *tmp_plus_1;
			}
			pivot++;
		}
	}
	quicksort_triangle_list(start, pivot - 1);
	quicksort_triangle_list(pivot + 1, end);	
}

void three_point_sort(
	float * p1x, float * p1y, float * p1z, 
	float * p2x, float * p2y, float * p2z, 
	float * p3x, float * p3y, float * p3z){
	
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
	
}

void z_clip_line(
	float p1x, float p1y, float p1z, float p2x, float p2y, float p2z, float clip,
	float * nx, float * ny, float * nz){
	
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
}

void render_object(object_t * object){
	for(int i = 0; i < object->num_vertices; i++){
		object->t_vertices[i][3] = object->t_vertices[i][0] * k_screen_scale / object->t_vertices[i][4] + k_x_center;
		object->t_vertices[i][4] = object->t_vertices[i][0] * k_screen_scale / object->t_vertices[i][4] + k_x_center;
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
				
				if ( (s1x > 0 && s2x > 0 && s3x > 0) && (s1x < 128 && s2x < 128 && s3x < 128) ){
					if(( (s1x-s2x)*(s3y-s2y)-(s1y-s2y)*(s3x-s2x)) < 0){
						if(object->color_mode==k_colorize_dynamic){
							p2x -= p1x;
							p2y -= p1y;
							p2z -= p1z;
							
							float nx = p2y * p3z - p2z * p3y;
							float ny = p2z * p3x - p2x * p3z;
							float nz = p2x * p3y - p2y * p3x;
							
							nx *= 4;
							ny *= 4;
							nz *= 4;
							
							float inv_dist = 1 / sqrt(nx * nx + ny * ny + nz * nz);
							nx *= inv_dist;
							ny *= inv_dist;
							nz *= inv_dist;
							
							float mid, b;
							b = nx*t_light_x+ny*t_light_y+nz*t_light_z;
							if ( b <= 0 ) mid = 0 + k_ambient;
							else if ( b >= 1) mid = (1-k_ambient) + k_ambient;
							else mid = b * (1-k_ambient) + k_ambient;
							
							color_shade(object->faces[i][4], mid, &object->faces[i][4], &object->faces[i][5]);
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
						(s4x < 128 && s4x < 128 && s4x < 128)){
						
						new_triangle(s1x, s1y, s2x, s2y, s4x, s4y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);
						
					}
					
					if( (s2x > 0 && s3x > 0 && s4x > 0) &&
						(s2x < 128 && s3x < 128 && s4x < 128)){
						
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
						(s1x < 128 && s2x < 128 && s3x < 128)){
						
						new_triangle(s1x, s1y, s2x, s2y, s3x, s3y, z_paint, object->faces[i][k_color1], object->faces[i][k_color2]);
						
					}
					
				}
			}
		}
	}
	
}

void draw_3d(){
	
	quicksort_object_list(0, object_list_used);
	for(int i = 0; i < object_list_used; i++){
		if( (object_list + i)->visible == 1 &&
			(object_list + i)->background != 1){
			render_object( (object_list + i) );
		}
	}
	
	quicksort_triangle_list(0, triangle_list_used);
	
	//~ draw_triangle_list();
	
}

void draw(){
	
	cur_frame += 1;
	scene_background_func();
	
	update_3d();
	
	// left off here
	draw_3d();
	
}

int main(){
	
	srand(time(NULL));
	
	init();
	
	while (!quit){
		update();
		draw();
	}
	
	if(object_list != NULL)   free(object_list);
	if(obstacle_list != NULL) free(obstacle_list);
	if(triangle_list != NULL) free(triangle_list);
	
	SDL_DestroyRenderer( renderer );
	SDL_DestroyWindow( window );
	SDL_Quit();
	
	return 0;
}
