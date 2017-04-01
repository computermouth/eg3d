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
float k_ambient = .3;
float mat00 = 0;
float mat10 = 0;
float mat20 = 0;
float mat01 = 0;
float mat11 = 0;
float mat21 = 0;
float mat02 = 0;
float mat12 = 0;
float mat22 = 0;

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
	float (*t_vertices)[3];
	int num_vertices;
	int num_faces;
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
	int color;
	int color_mode;
	int radius;
	int sradius;
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
	
	//~ obstacle_list_t obs_l = { .fake = NULL };
	//~ particle_list_t p_l = { .fake = NULL };
	
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

object_t * new_object(){
	object_t * obj = malloc(sizeof (object_t));
	
	//~ object_t obj = {
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
	//~ };
	
	add_object_to_list(obj);
	
	return obj;
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

void rotate_point(float (*v)[3], float (*t)[3]){
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
