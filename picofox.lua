--electric gryphon
--pico fox

--starfox cornerea music from http://www.khinsider.com/midi/snes/starfox
--sequenced by pjbarnes.com

--thanks to kittenm4ster's midi to pico-8 tracker translator
--https://github.com/andmatand/midi-to-pico8

tower_tall_v={
{6.000000,0.045053,-6.000000},
{6.000000,0.045053,6.000000},
{-6.000001,0.045053,5.999998},
{-5.999996,0.045053,-6.000004},
{6.000003,35,-5.999997},
{5.999996,35,6.000005},
{-6.000003,35,5.999997},
{-5.999999,35,-6.000000}
}

tower_tall_f={
{6,7,3,6,6},-- face a
{2,6,3,6,6}, --face a
{1,5,2,5,5}, --face b
{5,6,2,5,5}, --face b
--{8,7,6,6,5}, --face c
--{5,8,6,6,5}, --face c
{7,8,4,13,13}, --face d
{3,7,4,13,13} -- face d
}

tower_tall_blue_f={
{6,7,3,1,1},-- face a
{2,6,3,1,1}, --face a
{1,5,2,1,13}, --face b
{5,6,2,1,13}, --face b
--{8,7,6,6,5}, --face c
--{5,8,6,6,5}, --face c
{7,8,4,13,12}, --face d
{3,7,4,13,12} -- face d
}

tower_tall_red_f={
{6,7,3,2,2},-- face a
{2,6,3,2,2}, --face a
{1,5,2,2,1}, --face b
{5,6,2,2,1}, --face b
--{8,7,6,6,5}, --face c
--{5,8,6,6,5}, --face c
{7,8,4,2,4}, --face d
{3,7,4,2,4} -- face d
}

tower_tall_wide_v={
{6.000000,0.045053,-21.5},
{6.000000,0.045053,6.000000},
{-21.000001,0.045053,6},
{-21.5,0.045053,-21.5},
{6.000003,35,-21.5},
{6,35,6},
{-21.5,35,6},
{-21.5,35,-21.5}
}

tower_medium_wide_v={
{6.000000,0.045053,-21.5},
{6.000000,0.045053,6.000000},
{-21.000001,0.045053,6},
{-21.5,0.045053,-21.5},
{6.000003,25,-21.5},
{6,25,6},
{-21.5,25,6},
{-21.5,25,-21.5}
}

tower_short_wide_v={
{6.000000,0.045053,-21.5},
{6.000000,0.045053,6.000000},
{-21.000001,0.045053,6},
{-21.5,0.045053,-21.5},
{6.000003,15,-21.5},
{6,15,6},
{-21.5,15,6},
{-21.5,15,-21.5}
}

tower_medium_v={
{6.000000,0.045053,-6.000000},
{6.000000,0.045053,6.000000},
{-6.000001,0.045053,5.999998},
{-5.999996,0.045053,-6.000004},
{6.000003,25,-5.999997},
{5.999996,25,6.000005},
{-6.000003,25,5.999997},
{-5.999999,25,-6.000000}
}

tower_medium_f={
{6,7,3,6,6},-- face a
{2,6,3,6,6}, --face a
{1,5,2,5,5}, --face b
{5,6,2,5,5}, --face b
{8,7,6,7,7}, --face c
{5,8,6,7,7}, --face c
{7,8,4,13,13}, --face d
{3,7,4,13,13} -- face d
}

tower_medium_blue_f={
{6,7,3,1,1},-- face a
{2,6,3,1,1}, --face a
{1,5,2,1,13}, --face b
{5,6,2,1,13}, --face b
{8,7,6,13,13}, --face c
{5,8,6,13,13}, --face c
{7,8,4,13,1}, --face d
{3,7,4,13,1} -- face d
}

tower_medium_red_f={
{6,7,3,2,2},-- face a
{2,6,3,2,2}, --face a
{1,5,2,2,1}, --face b
{5,6,2,2,1}, --face b
{8,7,6,2,14}, --face c
{5,8,6,2,14}, --face c
{7,8,4,2,4}, --face d
{3,7,4,2,4} -- face d
}


tower_short_v={
{6.000000,0.045053,-6.000000},
{6.000000,0.045053,6.000000},
{-6.000001,0.045053,5.999998},
{-5.999996,0.045053,-6.000004},
{6.000003,15,-5.999997},
{5.999996,15,6.000005},
{-6.000003,15,5.999997},
{-5.999999,15,-6.000000}
}

column_v={
{2.000000,0.045053,-2.000000},
{2.000000,0.045053,2.000000},
{-2.000001,0.045053,2},
{-2,0.045053,-2},
{2.000003,25,-2},
{2,25,3.000005},
{-2.000003,25,2},
{-2,25,-2.000000}
}

column_f={
{6,7,3,1,1},-- face a
{2,6,3,1,1}, --face a
{1,5,2,1,3}, --face b
{5,6,2,1,3}, --face b
{8,7,6,13,6}, --face c
{5,8,6,13,6}, --face c
{7,8,4,1,13}, --face d
{3,7,4,1,13} -- face d
}

small_block_v={
{2.560000,0.022037,-2.560000},
{2.560000,0.022037,2.560000},
{-2.560000,0.022037,2.559999},
{-2.559999,0.022037,-2.560001},
{4.000002,4.022038,-3.999998},
{3.999998,4.022038,4.000002},
{-4.000001,4.022038,3.999999},
{-4.000000,4.022038,-4.000000},
{2.560001,8.022038,-2.559999},
{2.559999,8.022038,2.560002},
{-2.560001,8.022038,2.559999},
{-2.560000,8.022038,-2.560000}
}

small_block_f={
{6,10,11	,6,6  }, --tf
{7,6,11		,6,6  }, --tf
{3,2,7		,13 ,13   }, --bf
{2,6,7		,13 ,13  }, --bf
{1,5,6		,5 ,1   }, --bl
{2,1,6		,5 ,1   }, --bl
{5,9,10		,5 ,5   }, --tl
{6,5,10		,5 ,5   }, --tl
{7,8,4		,13 ,5   }, --br
{3,7,4		,13 ,5   }, --br
{8,7,12		,13 ,13   }, --tr
{7,11,12	,13,13  }, --tr
{12,11,10	,7,7  }, --top
{9,12,10	,7 ,7   }, --top
}

atc_v={
{1.57362,0.028255,-1.57362},
{1.57362,0.028255,1.57362},
{-1.57362,0.028255,1.57362},
{-1.57361,0.028255,-1.57363},
{1.127749,21.761099,-1.127747},
{1.127747,21.761099,1.127749},
{-1.127748,21.761099,1.127748},
{-1.127748,21.761099,-1.127748},
{2.966041,23.744837,-2.966038},
{2.966037,23.744837,2.966041},
{-2.966040,23.744837,2.966038},
{-2.966039,23.744837,-2.966040},
{1.442129,26.852680,-1.442128},
{1.442128,26.852680,1.442130},
{-1.442130,26.852680,1.442129},
{-1.442129,26.852680,-1.442129}
}

atc_f={
{6,7,3		,6 ,6  }, --bf
{2,6,3		,6,6 }, --bf
{5,6,2		,5 ,5  }, --bl
{1,5,2		,5,5 }, --bl
{7,8,4		,13 ,13  }, --br
{3,7,4		,13,13 }, --br


{6,10,11	,8 ,8  }, --cbf
{7,6,11		,8, 8  }, --cbf
{10,14,15	,15 ,15  }, --ctf
{11,10,15	,15, 15  },--ctf

{7,11,12	,4 ,8  }, --cbr
{8,7,12		,4,8}, --cbr
{12,11,15	,14 ,14  }, --ctr
{16,12,15	,14,14},	--ctr

{5,9,10		,4 ,4  }, --cbl
{6,5,10		,4, 4  }, --cbl
{9,13,14	,4,4},	--ctl
{10,9,14	,4, 4  }, --ctl
}

gate_left_v={
{-6.385633,0.056900,-1.581046},
{-10.385633,0.056900,-1.581046},
{-6.385633,9.280018,-1.581046},
{-10.385633,9.280018,-1.581046},
{-7.570441,0.056900,0.788571},
{-9.200825,0.056900,0.788571},
{-9.200825,9.280018,0.788571},
{-7.570441,9.280018,0.788571}
}

gate_left_f={
{8,5,1,		5 ,5 },--l
{6,5,8,		6 ,6 },--f
{7,4,2,		13 ,13 },--r
{3,8,1,		5 ,5 },--l
{7,6,8,		6 ,6 },--f
{6,7,2,		13 ,13 } --r
}

gate_right_v={
{6.385633,0.056900,-1.581046},
{10.385633,0.056900,-1.581046},
{6.385633,9.280018,-1.581046},
{10.385633,9.280018,-1.581046},
{7.570441,0.056900,0.788571},
{9.200825,0.056900,0.788571},
{9.200825,9.280018,0.788571},
{7.570441,9.280018,0.788571}
}

gate_right_f={
{8,5,1,		13 ,13 },--l
{6,5,8,		6 ,6 },--f
{7,4,2,		5 ,5 },--r
{3,8,1,		13 ,13 },--l
{7,6,8,		6 ,6 },--f
{6,7,2,		5 ,5 } --r
}


gate_top_v={
{-5.527887,10.090361,-1.581046},
{-6.374729,9.280018,-1.581046},
{-10.374729,9.280018,-1.581046},
{-5.527887,14.090361,-1.581046},
{5.533557,10.090361,-1.581046},
{6.380398,9.280018,-1.581046},
{10.380400,9.280018,-1.581046},
{5.533557,14.090361,-1.581046},
{-9.189920,9.280018,0.788571},
{-7.559537,9.280018,0.788571},
{-5.527887,12.904385,0.790907},
{-5.527887,11.276337,0.790907},
{9.195591,9.280018,0.788571},
{7.565207,9.280018,0.788571},
{5.533557,12.904385,0.790907},
{5.533557,11.276337,0.790907}
}

gate_top_f={
{7,15,13,		7,7},--lt
{8,15,7,		7 ,7 },--lf
{16,13,15,		6 ,6 },--lf
{14,13,16,		6 ,6},--lf

{14,5,6,		13,5 },--lb
{16,5,14,		13,5 },--lb

{10,12,9,		6 ,6 },--rf
{12,11,9,		6 ,6 },--rf
{10,2,1,		5 ,1 },--rb
{12,10,1,		5 ,1 },--rb
{3,9,11,		13,13 },--rt
{4,3,11,		13,13},--rt

{1,5,16,		5 ,1 },--cb
{12,1,16,		5 ,1 },--cb

{11,15,8,		6, 7},--ct
{4,11,8,		6 ,7},--ct
{11,12,15,		6 ,6},--cf
{12,16,15,		6 ,6},--cf
}

ring_v={
{1.314192,-4.043813,-4.092414},
{-0.030381,-5.381969,-3.967768},
{-0.030382,-3.967754,-5.381979},
{1.314192,-5.753181,-0.034364},
{-0.030381,-6.611262,0.999994},
{-0.030382,-6.611260,-1.000006},
{1.314192,-4.092413,4.043815},
{-0.030381,-3.967766,5.381971},
{-0.030382,-5.381978,3.967756},
{1.314192,-0.034362,5.753181},
{-0.030381,0.999996,6.611262},
{-0.030382,-1.000004,6.611260},
{1.314192,4.043817,4.092410},
{-0.030381,5.381973,3.967762},
{-0.030382,3.967759,5.381975},
{1.314192,5.753182,0.034360},
{-0.030381,6.611262,-0.999999},
{-0.030382,6.611261,1.000001},
{1.314192,4.092410,-4.043818},
{-0.030381,3.967762,-5.381974},
{-0.030382,5.381975,-3.967760},
{1.314192,0.034359,-5.753181},
{-0.030381,-1.000000,-6.611261},
{-0.030382,1.000000,-6.611261}
}

ring_f={
{1,2,3		,10,9},
{4,5,6		,10,9},
{7,8,9		,10,9},
{10,11,12	,10,9},
{13,14,15	,10,9},
{16,17,18	,10,9},
{19,20,21	,10,9},
{22,23,24	,10,9}
}


sparrow_shadow_v ={
{-0.000000,-0.143790,-4.131912},
	{1.444643,-0.143790,-0.131913},
	{-1.444643,-0.143790,-0.131913},
	{-1.335428,-0.143790,-0.269312},
	{-3.899004,-0.143790,0.976128},
	{-0.736040,-0.143790,-1.590867},
	{1.335428,-0.143790,-0.269312},
	{3.899004,-0.143790,0.976128},
	{0.736040,-0.143790,-1.590867}
}

sparrow_shadow_f={
	{3,1,2,3,3},
	{4,5,6,3,3},
	{7,9,8,3,3}
}

missile_v={
{0.605502,-0.016251,-0.483898},
{-0.622070,-0.016251,-0.483897},
{-0.005903,0.000000,-3.763774},
{-0.005823,0.612172,0.114134},
{-0.000387,-0.622139,0.114134},
{-0.513121,-0.012158,-0.942357},
{-0.982464,-0.008801,0.965153},
{-1.269821,-0.476112,-0.362477},
{-1.263134,0.458825,-0.362477},
{0.495601,-0.012158,-0.942357},
{0.964944,-0.008801,0.965153},
{1.252301,-0.476112,-0.362477},
{1.245614,0.458825,-0.362477}
}

missile_f={
{5,3,1,		7 ,7 }, --body b
{4,5,1,		8 ,9 }, --bady back
{2,4,3,		6 ,6 },
{4,2,5,		9 ,4 }, --body back
{4,1,3,		5 ,5 },
{6,9,7,		6 ,6 },
{9,8,7,		5 ,5 },
{8,6,7,		6 ,6 }, --engine back
{8,9,6,		5 ,5 }, --engine 
{3,5,2,		5,5}, --body c
{10,11,13,	6,6}, --body a
{13,11,12,	5,5}, 
{12,11,10,	6,6}, --engine back
{12,10,13,	5,5} --engine 
}

bird_v={
{1.366011,-0.551232,-0.404929},
{-1.396024,-0.551232,-0.404928},
{-0.009650,-2.533146,-3.288191},
{-0.009470,1.293751,-0.791158},
{1.292668,0.055527,-1.062871},
{3.097031,1.765656,-1.326379},
{2.524086,2.736222,-0.714591},
{4.102667,-0.470794,-0.365055},
{4.806459,2.715913,0.201633},
{-2.410486,-0.758736,-0.505636},
{-1.882767,-1.109086,-0.882269},
{-3.522005,-2.970685,1.731706},
{-1.472019,-0.057090,-0.649734},
{-1.294312,0.055527,-1.062871},
{-3.098674,1.765656,-1.326379},
{-2.525730,2.736222,-0.714591},
{-4.104311,-0.470794,-0.365055},
{-4.808104,2.715913,0.201633},
{2.408843,-0.758736,-0.505635},
{1.881123,-1.109086,-0.882269},
{3.520360,-2.970685,1.731707},
{1.470375,-0.057090,-0.649734}
}

bird_f={
{2,4,3,		6 ,6 }, --body_left
{4,1,3,		7,7}, --body right
{6,9,8,		13 ,14 }, --right wing lower right
{9,7,8,		14 ,14 },
{5,6,8,		13 ,13 }, --right wing lower left
{7,9,6,		15 ,15 }, --right right upper side
{7,6,5,		14 ,14 },--wing right upper
{5,8,7,		15 ,15 }, --right wing back
{3,1,2,		5 ,5 },
{1,4,2,		5,5}, --body under
{11,13,12,	9,9},  --leg left
{13,10,12,	9,9}, --leg left
{12,10,11,	9,9}, --leg left
{10,13,11,	9,9}, --leg left
{15,17,18,	13,2}, --left wing left low
{18,17,16,	14 , 14},
{14,17,15,	13 , 13}, --left wing right low
{16,15,18,	14 , 14}, --left wing left upper
{16,14,15,	15 , 15}, --left wing right upper
{14,16,17,	15 , 15},
{20,21,22,	9 , 9}, --right leg
{22,21,19,	9 , 9}, --right leg
{21,20,19,	9 , 9}, --right leg
{19,20,22,	5 , 5}
}

fox_v={
{0.986111,-0.025855,0.300339},
{-1.005903,-0.025855,0.300340},
{-0.005903,0.000000,-3.763774},
{-0.005903,1.000000,0.300339},
{-0.005903,0.525322,1.004954},
{-1.636132,-0.269847,-0.689093},
{-1.874824,0.244348,0.182332},
{-1.743159,1.274788,1.228072},
{-1.264151,0.050001,0.029176},
{-4.5,-1.035814,1.553706},
{-1.189264,-0.440330,-1.404416},
{-1.015540,0.175132,0.075046},
{1.851038,0.244348,0.182331},
{1.240366,0.050001,0.029176},
{0.991755,0.175132,0.075046},
{1.612347,-0.269847,-0.689093},
{4.5,-1.035814,1.553705},
{1.165478,-0.440330,-1.404416},
{1.719373,1.274788,1.228071}
}

fox_f={
{1,4,5,		5 ,5 },	--cowel left
{4,2,5,		6 ,6 }, --cowel right
{2,1,5,		9 ,8 }, --engine
{2,4,3,		7 ,7 }, --ship right
{1,2,3,		5 ,5 }, --ship bottom
{4,1,3,		6 ,6 }, --ship left
{6,7,2,		7 ,7 }, --right wing inside
{10,7,6,	6 ,6 }, --right wing front --hidden
{10,2,7,	6 ,6 }, --right wing top
{6,2,10,	5,5}, --right wing bottom
{11,9,8,	1,1},
{9,8,12,	1,1}, --right spoil top
{9,11,12,	1,1}, --right spoil side
{11,12,8,	1,1}, --right spoil front
{17,16,13,	6,6}, --right wing front
{18,19,14,	1 ,1 },
{14,19,15,	1 ,1 }, --left spoil top
{14,15,18,	1 ,1 }, --left spoil side
{18,15,19,	1 ,1 }, --left spoil bottom
{17,1,13,	6 ,6 }, --left wing back
{16,13,1,	6 ,6 }, 
{16,17,1,	5 ,5 } --left wing bottom
}

k_ground_level=-3

k_color1=4
k_color2=5

k_screen_scale=80
k_x_center=64
k_y_center=64



z_clip=-1.5
z_max=-120

k_min_x=0
k_max_x=128
k_min_y=0
k_max_y=128

k_title_mode=1
k_level_select_mode=2
k_play_mode=3
k_win_mode=4

level_list={"cornerea","venom","fortuna"}
level_color={{3,3,3,11,12,11},
			 {2,2,2,4,8,4},
			 {9,9,9,10,14,10},
			 }

function load_object(object_vertices,object_faces)
	object=new_object()
	
	object.vertices=object_vertices
	object.faces=object_faces
	
	object.radius=0
	
	for i=1,#object_vertices do
		object.t_vertices[i]={}
	end
	
	set_radius(object)
	set_bounding_box(object)
	
	return object
end

function set_radius(object)
	for vertex in all(object.vertices) do
		object.radius=max(object.radius,vertex[1]*vertex[1]+vertex[2]*vertex[2]+vertex[3]*vertex[3])
	end
	object.radius=sqrt(object.radius)
end

function set_bounding_box(object)
		generate_matrix_transform(object.ax,object.ay,object.az)
	for vertex in all(object.vertices) do
	
		object.min_x=min(vertex[1],object.min_x)
		object.min_y=min(vertex[2],object.min_y)
		object.min_z=min(vertex[3],object.min_z)
		object.max_x=max(vertex[1],object.max_x)
		object.max_y=max(vertex[2],object.max_y)
		object.max_z=max(vertex[3],object.max_z)
	end

end

function intersect_bounding_box(object_a, object_b)
	return 
        ((object_a.min_x+object_a.x < object_b.max_x+object_b.x) and (object_a.max_x+object_a.x > object_b.min_x+object_b.x) and
         (object_a.min_y+object_a.y < object_b.max_y+object_b.y) and (object_a.max_y+object_a.y > object_b.min_y+object_b.y) and
         (object_a.min_z+object_a.z < object_b.max_z+object_b.z) and (object_a.max_z+object_a.z > object_b.min_z+object_b.z))
end




function new_object()
	object={}
	object.vertices={}
	object.faces={}
	
	object.t_vertices={}

	
	object.x=0
	object.y=0
	object.z=0
	
	object.rx=0
	object.ry=0
	object.rz=0
	
	object.tx=0
	object.ty=0
	object.tz=0
	
	object.ax=0
	object.ay=0
	object.az=0
	
	object.sx=0
	object.sy=0
	object.radius=10
	object.sradius=10
	object.visible=true
	
	object.render=true
	object.background=false
	object.collision_x=true
	object.collision_y=false
	object.collision_down=false
	object.collision_up=false
	object.collision_left=false
	object.ring=false
	
	object.min_x=100
	object.min_y=100
	object.min_z=100
	
	object.max_x=-100
	object.max_y=-100
	object.max_z=-100
	
	object.vx=0
	object.vy=0
	object.vz=0

	object.age=0
	object.health=2
	add(object_list,object)
	return object

end

function delete_object(object)
	del(object_list,object)
end

function new_triangle(p1x,p1y,p2x,p2y,p3x,p3y,z,c1,c2)
	t={}
	t.p1x=p1x
	t.p1y=p1y
	t.p2x=p2x
	t.p2y=p2y
	t.p3x=p3x
	t.p3y=p3y
	t.z=z
	t.c1=c1
	t.c2=c2

	add(triangle_list,t)
end

function draw_triangle_list()
	for t in all(triangle_list) do		
		solid_trifill( t.p1x,t.p1y,t.p2x,t.p2y,t.p3x,t.p3y, t.c1,t.c2 )
	end
end


function transform_object(object)
	

		object.visible=false

		local px,py,pz = object.x-cam_x,object.y-cam_y,object.z-cam_z
		object.tx, object.ty, object.tz =rotate_cam_point(px,py,pz)

		object.sx,object.sy = project_point(object.tx,object.ty,object.tz)
		object.sradius=project_radius(object.radius,object.tz)
		object.visible= is_visible(object)
	
	if(object.visible)then
		generate_matrix_transform(object.ax,object.ay,object.az)
		for i=1, #object.vertices do
			object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3]=rotate_point(object.vertices[i][1],object.vertices[i][2],object.vertices[i][3])
		
			object.t_vertices[i][1]+=object.x - cam_x
			object.t_vertices[i][2]+=object.y - cam_y
			object.t_vertices[i][3]+=object.z - cam_z
			
			object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3]=rotate_cam_point(object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3])
		
		end
	

	end
end

function generate_matrix_transform(xa,ya,za)

	
	local sx=sin(xa)
	local sy=sin(ya)
	local sz=sin(za)
	local cx=cos(xa)
	local cy=cos(ya)
	local cz=cos(za)
	
	mat00=cz*cy
	mat10=-sz
	mat20=cz*sy
	mat01=cx*sz*cy+sx*sy
	mat11=cx*cz
	mat21=cx*sz*sy-sx*cy
	mat02=sx*sz*cy-cx*sy
	mat12=sx*cz
	mat22=sx*sz*sy+cx*cy

end

function generate_cam_matrix_transform(xa,ya,za)

	
	local sx=sin(xa)
	local sy=sin(ya)
	local sz=sin(za)
	local cx=cos(xa)
	local cy=cos(ya)
	local cz=cos(za)
	
	cam_mat00=cz*cy
	cam_mat10=-sz
	cam_mat20=cz*sy
	cam_mat01=cx*sz*cy+sx*sy
	cam_mat11=cx*cz
	cam_mat21=cx*sz*sy-sx*cy
	cam_mat02=sx*sz*cy-cx*sy
	cam_mat12=sx*cz
	cam_mat22=sx*sz*sy+cx*cy

end


function	matrix_inverse()
	local det = mat00* (mat11 * mat22- mat21 * mat12) -
                mat01* (mat10 * mat22- mat12 * mat20) +
                mat02* (mat10 * mat21- mat11 * mat20)
	local invdet=2/det
		

		
		mat00,mat01,mat02,mat10,mat11,mat12,mat20,mat21,mat22=(mat11 * mat22 - mat21 * mat12) * invdet,(mat02 * mat21 - mat01 * mat22) * invdet,(mat01 * mat12 - mat02 * mat11) * invdet,(mat12 * mat20 - mat10 * mat22) * invdet,(mat00 * mat22 - mat02 * mat20) * invdet,(mat10 * mat02 - mat00 * mat12) * invdet,(mat10 * mat21 - mat20 * mat11) * invdet,(mat20 * mat01 - mat00 * mat21) * invdet,(mat00 * mat11 - mat10 * mat01) * invdet

end

function rotate_point(x,y,z)	
	return (x)*mat00+(y)*mat10+(z)*mat20,(x)*mat01+(y)*mat11+(z)*mat21,(x)*mat02+(y)*mat12+(z)*mat22
end

function rotate_cam_point(x,y,z)

	
	return (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20,(x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21,(x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22
end

function is_visible(object)

	if(object.tz+object.radius>z_max and object.tz-object.radius<z_clip and
	   object.sx+object.sradius>0 and object.sx-object.sradius<128 and
	   object.sy+object.sradius>0 and object.sy-object.sradius<128 )
	   then return true else return false end
end

function	cross_product_2d(p0x,p0y,p1x,p1y,p2x,p2y)
	return ( ( (p0x-p1x)*(p2y-p1y)-(p0y-p1y)*(p2x-p1x)) > 0 )
end

function render_object(object)

	for face in all(object.faces) do
		local p1x=object.t_vertices[face[1]][1]
		local p1y=object.t_vertices[face[1]][2]
		local p1z=object.t_vertices[face[1]][3]
		local p2x=object.t_vertices[face[2]][1]
		local p2y=object.t_vertices[face[2]][2]
		local p2z=object.t_vertices[face[2]][3]
		local p3x=object.t_vertices[face[3]][1]
		local p3y=object.t_vertices[face[3]][2]
		local p3z=object.t_vertices[face[3]][3]
		
		local cz=.01*(p1z+p2z+p3z)/3
		local cx=.01*(p1x+p2x+p3x)/3
		local cy=.01*(p1y+p2y+p3y)/3
		local z_paint= -cx*cx-cy*cy-cz*cz
		
		
		if(object.background==true) z_paint-=1000 
			
		

		if((p1z>z_max or p2z>z_max or p3z>z_max))then
			if(p1z< z_clip and p2z< z_clip and p3z< z_clip)then

					local s1x,s1y = project_point(p1x,p1y,p1z)
					local s2x,s2y = project_point(p2x,p2y,p2z)
					local s3x,s3y = project_point(p3x,p3y,p3z)

					if( max(s3x,max(s1x,s2x))>0 and min(s3x,min(s1x,s2x))<128)  then
							new_triangle(s1x,s1y,s2x,s2y,s3x,s3y,z_paint,face[k_color1],face[k_color2])
					end
					
					
			elseif(p1z< z_clip or p2z< z_clip or p3z< z_clip)then
			
			--either going to have 3 or 4 points
				p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z = three_point_sort(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
				if(p1z<z_clip and p2z<z_clip)then
				

				
					local n2x,n2y,n2z = z_clip_line(p2x,p2y,p2z,p3x,p3y,p3z,z_clip)
					local n3x,n3y,n3z = z_clip_line(p3x,p3y,p3z,p1x,p1y,p1z,z_clip)
					

					
					local s1x,s1y = project_point(p1x,p1y,p1z)
					local s2x,s2y = project_point(p2x,p2y,p2z)
					local s3x,s3y = project_point(n2x,n2y,n2z)
					local s4x,s4y = project_point(n3x,n3y,n3z)
					--solid_trifill(s1x,s1y,s2x,s2y,s4x,s4y,face[k_color1])
					--solid_trifill(s2x,s2y,s4x,s4y,s3x,s3y,face[k_color1])
					
					if( max(s4x,max(s1x,s2x))>0 and min(s4x,min(s1x,s2x))<128)  then
						new_triangle(s1x,s1y,s2x,s2y,s4x,s4y,z_paint,face[k_color1],face[k_color2])
					end
					if( max(s4x,max(s3x,s2x))>0 and min(s4x,min(s3x,s2x))<128)  then
						new_triangle(s2x,s2y,s4x,s4y,s3x,s3y,z_paint,face[k_color1],face[k_color2])
					end
				else

				
					local n1x,n1y,n1z = z_clip_line(p1x,p1y,p1z,p2x,p2y,p2z,z_clip)
					local n2x,n2y,n2z = z_clip_line(p1x,p1y,p1z,p3x,p3y,p3z,z_clip)
					

					
					local s1x,s1y = project_point(p1x,p1y,p1z)
					local s2x,s2y = project_point(n1x,n1y,n1z)
					local s3x,s3y = project_point(n2x,n2y,n2z)
					
					--solid_trifill(s1x,s1y,s2x,s2y,s3x,s3y,face[k_color1])
					if( max(s3x,max(s1x,s2x))>0 and min(s3x,min(s1x,s2x))<128)  then
						new_triangle(s1x,s1y,s2x,s2y,s3x,s3y,z_paint,face[k_color1],face[k_color2])
					end
				end
				
				--print("p1",p1x+64,p1z+64,14)
				--print("p2",p2x+64,p2z+64,14)
				--print("p3",p3x+64,p3z+64,14)
				
			
			
			end
		end
		
	end


end



function three_point_sort(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
	if(p1z>p2z) p1z,p2z = p2z,p1z p1x,p2x = p2x,p1x p1y,p2y = p2y,p1y
	if(p1z>p3z) p1z,p3z = p3z,p1z p1x,p3x = p3x,p1x p1y,p3y = p3y,p1y
	if(p2z>p3z) p2z,p3z = p3z,p2z p2x,p3x = p3x,p2x p2y,p3y = p3y,p2y
	
	return p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z
end



function sort_triangle_list()
  --for i=1,#a do
  for i=1,#triangle_list do
    local j = i
   while j > 1 and triangle_list[j-1].z > triangle_list[j].z do 
      triangle_list[j],triangle_list[j-1] = triangle_list[j-1],triangle_list[j]
      j = j - 1
    end
  end
end

function sort_object_list()
  --for i=1,#a do
  for i=1,#object_list do
     j = i
   while j > 1 and object_list[j-1].tz > object_list[j].tz do 
      object_list[j],object_list[j-1] = object_list[j-1],object_list[j]
      j = j - 1
    end
  end
end



function z_clip_line(p1x,p1y,p1z,p2x,p2y,p2z,clip)
	if(p1z>p2z)then
		p1x,p2x=p2x,p1x
		p1z,p2z=p2z,p1z
		p1y,p2y=p2y,p1y
	end
	
	if(clip>p1z and clip<=p2z)then

	--	line(p1x+64,p1z+64,p2x+64,p2z+64,14)
		alpha= abs((p1z-clip)/(p2z-p1z))
		nx=lerp(p1x,p2x,alpha)
		ny=lerp(p1y,p2y,alpha)
		nz=lerp(p1z,p2z,alpha)
				
	--	circ(nx+64,nz+64,1,12)
		return nx,ny,nz
	else
		return false
	end
end

function project_point(x,y,z)
	return x*k_screen_scale/z+k_x_center,y*k_screen_scale/z+k_x_center
end

function project_radius(r,z)
	return r*k_screen_scale/abs(z)
end


--moved all lerp functions inline
function solid_trifill( x1,y1,x2,y2,x3,y3, color1,color2, object, face )


		  -- order triangle points so that y1 is on top
		  
		  local x1=band(x1,0xffff)
		  local x2=band(x2,0xffff)
		  local y1=band(y1,0xffff)
		  local y2=band(y2,0xffff)
		  local x3=band(x3,0xffff)
		  local y3=band(y3,0xffff)
		  
		  
		  
		  
		  if(y2<y1) then
			if(y3<y2) then
			  local tmp = y1
			  y1 = y3
			  y3 = tmp
			  tmp = x1
			  x1 = x3
			  x3 = tmp
			else
			  local tmp = y1
			  y1 = y2
			  y2 = tmp
			  tmp = x1
			  x1 = x2
			  x2 = tmp
			end
		  else
			if(y3<y1) then
			  local tmp = y1
			  y1 = y3
			  y3 = tmp
			  tmp = x1
			  x1 = x3
			  x3 = tmp
			end
		  end

		  y1 += 0.001 -- offset to avoid divide per 0

		  local miny = min(y2,y3)
		  local maxy = max(y2,y3)

		  local fx = x2
		  if(y2<y3) then
			fx = x3
		  end

		  local d12 = (y2-y1)
		  if(d12 != 0) d12 = 1.0/d12
		  local d13 = (y3-y1)
		  if(d13 != 0) d13 = 1.0/d13

		  local cl_y1 = max(-1,min(128,y1))

		  
		  local cl_miny = max(-1,min(128,miny))
		  local cl_maxy = max(-1,min(128,maxy))

		  for y=band(cl_y1,0xffff),cl_miny,1 do
		  
		  --a*(1.0-alpha)+b*alpha
			
			--local sx = lerp(x1,x3, (y-y1) * d13 )
			--local ex = lerp(x1,x2, (y-y1) * d12 )
			local alpha=(y-y1) * d13
			local sx=x1*(1.0-alpha)+x3*alpha
			
			alpha=(y-y1) * d12 
			local ex=x1*(1.0-alpha)+x2*alpha
			
			
			if(band(y,1)==0)then
				rectfill(sx,y,ex,y,color1)
			else
				rectfill(sx,y,ex,y,color2)
			end
			
			

		  end
		  
		  --a*(1.0-alpha)+b*alpha
		  --local sx = lerp(x1,x3, (miny-y1) * d13 )
		  local alpha=(miny-y1) * d13
		  local sx = x1*(1.0-alpha)+x3*alpha
		  
		  
		  --local ex = lerp(x1,x2, (miny-y1) * d12 )
		   alpha=((miny-y1) * d12)
		   local ex = x1*(1.0-alpha)+x2*alpha
		  
		 
		  
		  
		  local df = (maxy-miny)
		  if(df != 0) df = 1.0/df
		  
		  
	
		  for y=band(cl_miny,0xffff),cl_maxy,1 do
			--local sx2 = lerp(sx,fx, (y-miny) * df )
			--local ex2 = lerp(ex,fx, (y-miny) * df )
			
			local alpha=(y-miny) * df
			local sx2 = sx*(1.0-alpha)+fx*alpha
			local ex2 = ex*(1.0-alpha)+fx*alpha
			
			
			if(band(y,1)==0)then
				rectfill(sx2,y,ex2,y,color1)
			else
				rectfill(sx2,y,ex2,y,color2)
			end
			

			
			
		  end
end

function lerp(a,b,alpha)
  return a*(1.0-alpha)+b*alpha
end


k_shot_timeout=6
function handle_game_buttons()

	


	
	if(btn(0))then
		--player.x+=.4
		--player.vay+=.0015
		player.vx+=.2
	end
	
	if(btn(1))then
		--player.x+=-.4
		--player.vay+=-.0015
		player.vx+=-.2
	end
	if(btn(3))then
		--player.x+=.4
		--player.vay+=.0015
		player.vy+=.2
	end
	
	if(btn(2))then
		--player.x+=-.4
		--player.vay+=-.0015
		player.vy+=-.2
	end
	
	if(shot_timeout>0) shot_timeout-=1
	if(btn(4) and shot_timeout<=0)then
		generate_matrix_transform(player.ax,player.ay,player.az)
		svx,svy,svz = rotate_point(0,0,-1.5)
		new_shot(player.x+svx,player.y+svy,player.z+svz,svx*1.5,svy*1.5,svz-player.speed)
		shot_timeout=k_shot_timeout
		
		sfx(50,-1)
	end
	

	
end


k_max_health=15
function new_player()
	--player=load_object(sparrow_v,sparrow_f)
	player={}
	player=load_object(fox_v,fox_f)

	
	player_shadow = load_object(sparrow_shadow_v, sparrow_shadow_f)
	player_shadow.background=true
	
	player.speed=1
	
	
	player.health=k_max_health
	player.dead=false
	
	player.distance=0
	player.last_distance=0
	
end

k_air_friction=.85
k_left_limit=-30
k_right_limit=30
k_down_limit=0
k_up_limit=30
k_distance_scale=.1

function update_player()

	player.x+=player.vx
	player.y+=player.vy
	
	player.vx*=k_air_friction
	player.vy*=k_air_friction

	if(player.x>k_right_limit)player.x=k_right_limit
	if(player.x<k_left_limit)player.x=k_left_limit
	if(player.y>k_up_limit)player.y=k_up_limit
	if(player.y<k_down_limit)player.y=k_down_limit
	
	player.ay=player.vx*.05
	player.az=player.vx*.08
	
	player.ax=-player.vy*.1
	
	player.vay*=.9
	player.ay+=player.vay
	
	player.z-=player.speed
	
	player.last_distance=player.distance
	player.distance+=player.speed*k_distance_scale
		
	player_shadow.x=player.x
	player_shadow.z=player.z
	player_shadow.y=k_ground_level
	player_shadow.az=player.az*.5
	player_shadow.ay=player.ay*1
	player_shadow.ax=abs(player.ax*.5)
	
	if(player.health<=0 and player.dead==false)then
		for i=1,30 do new_particle(player.x,player.y,player.z,rnd(2)-1,rnd(2)-1,0,20,7) end
		
		player.dead=true
		player.dead_time=cur_frame
		player.faces={}
		player_shadow.faces={}
		
		sfx(54,-1)
	end
	
	--generate_matrix_transform(-player.ax,-player.ay,-player.az)
	--matrix_inverse()
	--cvx,cvy,cvz = rotate_point(0,0,-4)
	
	--if(player.virt_x>10 and player.ay<0) pvx*=.9 player.virt_x=10 player.ay*=.9
	--if(player.virt_x<-10) pvx=0 player.virt_x=-10
	
	if(player.z<-200) then
		--player.z+=200
		
		for object in all(object_list) do
			object.z+=200
		end
		
		for dot in all(ground_dot_list) do
			dot[3]+=200
		end

		
	end
	
end


function new_ground()
	ground_vertices={{-150,k_ground_level,-150},
					  {150,k_ground_level,-150},
					  {150,k_ground_level,-50},
					 {-150,k_ground_level,-50},
					   {60,k_ground_level,-10},
				      {-60,k_ground_level,-10},
					

					

					
					}
					
	ground_faces={{1,2,3,3,3},{3,4,1,3,3},
				{3,4,5,3,11},{5,6,4,3,11},				}
	
	ground=load_object(ground_vertices,ground_faces)
	ground.background=true
	
end

function update_ground()
	ground.z=player.z
end


function update_camera()

	cam_x=player.x*.7
	cam_y=player.y*.65+6
	cam_z=player.z+12	
	cam_az=-player.vx*.02
	
	generate_cam_matrix_transform(cam_ax,cam_ay,cam_az)

end



k_default_z = -100


k_map_update_limit=20
k_tile_tall_tower=1

k_tile_medium_tower=2
k_tile_short_tower=3
k_tile_column=4
k_tile_small_block=5
k_tile_atc=6
k_tile_gate=7
k_tile_tall_wide_tower=8
k_tile_medium_wide_tower=9
k_tile_short_wide_tower=10
k_tile_tall_blue_tower=11
k_tile_medium_blue_tower=12
k_tile_short_blue_tower=13
k_tile_tall_red_tower=14
k_tile_medium_red_tower=15
k_tile_short_red_tower=16
k_tile_ring=17

function populate_scenery()
	map_update_counter-=1
	
	if(map_update_counter<=0)then
		map_update_counter=k_map_update_limit
		for i=0,8 do
			tile=mget(map_column,i+9*level)
			local x=-(i-4)*15
			local y=k_ground_level
			local z=k_default_z+player.z
			if(tile!=0 and tile<=31)then
				if(tile==k_tile_tall_tower) obj=load_object(tower_tall_v,tower_tall_f)
				
				if(tile==k_tile_tall_blue_tower) obj=load_object(tower_tall_v,tower_tall_blue_f)
				
				if(tile==k_tile_tall_red_tower) obj=load_object(tower_tall_v,tower_tall_red_f)

				if(tile==k_tile_tall_wide_tower)obj=load_object(tower_tall_wide_v,tower_tall_f)

				if(tile==k_tile_medium_tower)obj=load_object(tower_medium_v,tower_medium_f)
				
				if(tile==k_tile_medium_blue_tower)obj=load_object(tower_medium_v,tower_medium_blue_f)
				
				if(tile==k_tile_medium_red_tower)obj=load_object(tower_medium_v,tower_medium_red_f)
				
				if(tile==k_tile_medium_wide_tower)obj=load_object(tower_medium_wide_v,tower_medium_f)

				if(tile==k_tile_short_tower)obj=load_object(tower_short_v,tower_medium_f)
				
				if(tile==k_tile_short_blue_tower)obj=load_object(tower_short_v,tower_medium_blue_f)
				
				if(tile==k_tile_short_red_tower)obj=load_object(tower_short_v,tower_medium_red_f)
				
				if(tile==k_tile_short_wide_tower)obj=load_object(tower_short_wide_v,tower_medium_f)

				if(tile==k_tile_atc)obj=load_object(atc_v,atc_f)

				if(tile==k_tile_column)obj=load_object(column_v,column_f)

				if(tile==k_tile_small_block)then
					obj=load_object(small_block_v,small_block_f)
					obj.collision_up=true
				end
				
				if(tile==k_tile_ring)then
					obj=load_object(ring_v,ring_f)
					obj.ay=.25 y=k_ground_level+6
					obj.collision_x=false
					obj.ring=true
				end
				
				if(tile==k_tile_gate)then
					obj=load_object(gate_left_v,gate_left_f)
					obj.x=x obj.y=k_ground_level obj.z=k_default_z+player.z
					add(obst_list,obj)
					
					obj=load_object(gate_right_v,gate_right_f)
					obj.x=x obj.y=k_ground_level obj.z=k_default_z+player.z
					add(obst_list,obj)
					
					obj=load_object(gate_top_v,gate_top_f)
					--obj.x=x obj.y=k_ground_level obj.z=k_default_z+player.z
					obj.collision_up=true
					--add(obst_list,obj)
				end
				
				obj.x=x obj.y=y obj.z=z
				add(obst_list,obj)
			end
		end
		
		
		map_column+=1
		
		if(map_column>130)game_mode=k_victory_mode
		
	end
	


	for obst in all(obst_list) do

		if(obst.z>player.z+20) then
			delete_object(obst)
			del(obst_list,obst)
			

			
		end
		
		
	end
	

	
end	



k_tile_bird_center=32
k_tile_bird_back=33
k_tile_bird_side=34
k_tile_missile=35


function populate_enemies()
	enemy_populate_counter-=1

	if(enemy_populate_counter<=0)then
		enemy_populate_counter=k_map_update_limit
		for i=0,8 do
			tile=mget(enemy_column,i+9*level)
			x=-(i-4)*15
			if(tile!=0 and tile>=32)then
				num_enemies+=1
				if(tile==k_tile_bird_center)then
					en=load_object(bird_v,bird_f)
					en.z=k_default_z+player.z en.x=x en.y=k_ground_level+10
					en.vz=-.25
					en.ay=.5
					en.tile=tile
					add(enemy_list,en)
				end
				if(tile==k_tile_bird_back)then
					en=load_object(bird_v,bird_f)
					en.z=10+player.z en.x=x en.y=k_ground_level+10
					en.vz=-1.5
					en.tile=tile
					add(enemy_list,en)
				end
				if(tile==k_tile_bird_side)then
					en=load_object(bird_v,bird_f)
					en.z=-70+player.z 
						if(x<0)then en.x=-40 en.vx=.5 en.ay=.25
						else en.x=40 en.vx=-.5  en.ay=-.25 end
						en.y=k_ground_level+10
					en.vz=-.5
					en.tile=tile
					add(enemy_list,en)
				end
				if(tile==k_tile_missile)then
					en=load_object(missile_v,missile_f)
					en.z=k_default_z+player.z en.x=x en.y=k_ground_level+10
					en.vz=-.25
					en.ay=.5
					en.tile=tile
					add(enemy_list,en)
				end
			end
			
			
		end
		enemy_column+=1
	end
end

function update_enemies()	
	for enemy in all(enemy_list) do
		enemy.x+=enemy.vx
		enemy.y+=enemy.vy
		enemy.z+=enemy.vz
		enemy.age+=1
		
		if(intersect_bounding_box(player, enemy)) then
			enemy.health=0
			player.health-=5
			sfx(51,-1)
		end
		
		if(enemy.tile==k_tile_bird_center)then enemy.ay=sin(cur_frame/50)*.03+.5 enemy.vx=-sin(cur_frame/50)*.5

			
			if(enemy.z>player.z+10) del(enemy_list,enemy) delete_object(enemy)
		end
		
		if(enemy.tile==k_tile_bird_side)then enemy.vy=sin(cur_frame/50)*.25  enemy.ay+=sin(cur_frame/50)*.01
		
		if(enemy.z>player.z+10) del(enemy_list,enemy) delete_object(enemy)
		end
		
		
		if(enemy.tile==k_tile_bird_back)then
			
			if(enemy.age<150) then
				enemy.ay=sin(cur_frame/50)*.02 enemy.vx=sin(cur_frame/50)*.3 
			else
				enemy.vx=0
				if(enemy.vz<-.35)enemy.vz+=.1
				if(enemy.ay<.5)enemy.ay+=.01
				if(enemy.z>player.z+10) del(enemy_list,enemy) delete_object(enemy)
			end
		end
		
		if(enemy.tile==k_tile_missile)then
			enemy.az+=.02
			enemy.vx+=(player.x-enemy.x)*.002
			enemy.vy+=(player.y-enemy.y)*.002
			if(enemy.z>player.z+10) del(enemy_list,enemy) delete_object(enemy)
		end
		
		for shot in all(player_shot_list) do
			if(intersect_bounding_box(shot, enemy)) impact(shot) enemy.health-=1 sfx(52,-1)
		end
		
		if(enemy.health<=0)then
					for i=1,6 do new_particle(enemy.x,enemy.y,enemy.z,rnd(2)-1,rnd(2)-1,0,20,7) end
					del(enemy_list,enemy)
					delete_object(enemy)
					sfx(55,-1)
					num_kills+=1
		end
		
	end
	
end

function impact(shot)
	new_particle(shot.x,shot.y,shot.z-shot.vz,0,0,-shot.vz*.5,20,9)
	--for i=1,2 do new_particle(shot.x,shot.y,shot.z-shot.vz,rnd(2)-1,rnd(2)-1,0,20,9) end
	delete_object(shot)
	del(player_shot_list,shot)
end

function check_collisions()
	for obst in all(obst_list) do
	
		if(intersect_bounding_box(player, obst)) then
			
			if(obst.collision_x)then
				if(player.x<obst.x) then
					player.x+=-1
				else player.x+=1
				end
			end
			
			if(obst.collision_y)then
				if(player.y<obst.y) then
					player.y+=-1
				else player.y+=1
				end
			end
			
			if(obst.collision_down)player.y-=1
			if(obst.collision_up)player.y+=1
			if(obst.collision_left)player.x-=1
			if(obst.collision_right)player.y+=1
			
			for i=1,2 do new_particle(player.x,player.y,player.z,rnd(2)-1,rnd(2)-1,0,20,12+flr(rnd(2))) end
			
			player.health-=.5
			if(object.ring) then sfx(56,-1) else sfx(53,-1) end
		end
		
		for shot in all(player_shot_list) do
			if(intersect_bounding_box(shot, obst))impact(shot)
			
		end
		
	end
end



function new_shot(x,y,z,vx,vy,vz)
	s=load_object({{-.5,0,0},{.5,0,0},{0,0,-1.5}},{{1,2,3,10,10}})
	s.min_x=-4
	s.max_x=4
	s.min_y=-4
	s.max_y=4
	s.min_z=-2
	s.max_z=8
	s.x=x
	s.y=y
	s.z=z
	
	s.vx=vx
	s.vy=vy
	s.vz=vz
	

	add(player_shot_list,s)

end

function update_shots()
	for shot in all(player_shot_list) do
		shot.age+=1
		shot.x+=shot.vx shot.y+=shot.vy	shot.z+=shot.vz
		
		if(shot.age>20) delete_object(shot)del(player_shot_list,shot)
			
		if(shot.y<k_ground_level)impact(shot)
	end
	
	
end


function new_particle(x,y,z,vx,vy,vz,life,color)
	particle_vertices={{-.5,0,0},{.5,0,0},{0,.7,0}}
	particle_faces={{1,2,3,color,color}}

	s=load_object(particle_vertices,particle_faces)
	s.x=x
	s.y=y
	s.z=z
	
	s.vx=vx
	s.vy=vy
	s.vz=vz
	
	s.az=rnd(1)
	
	s.life=life
	add(particle_list,s)
end

function update_particles()
	for particle in all(particle_list) do
		particle.x+=particle.vx
		particle.y+=particle.vy
		particle.z+=particle.vz
		
		particle.life-=1
		
		s.az+=.05
		
		if(particle.life<=0)delete_object(particle) del(particle_list,particle)
	end
end

function init_ground_dots()
	for i=1,5 do
		ground_dot_list[i]={-15,k_ground_level,-i*20+player.z}
		ground_dot_list[i+5]={15,k_ground_level,-i*20+player.z}
		ground_dot_list[i+10]={-45,k_ground_level,-i*20+player.z}
		ground_dot_list[i+15]={45,k_ground_level,-i*20+player.z}
	end
end

function update_ground_dots()
	for i=1,#ground_dot_list do
		if(ground_dot_list[i][3]>player.z) ground_dot_list[i][3]=player.z-100
	end
end

function render_ground_dots()
	for i=1,#ground_dot_list do
		tx1,ty1,tz1=rotate_cam_point(ground_dot_list[i][1]-cam_x,ground_dot_list[i][2]-cam_y,ground_dot_list[i][3]-cam_z)
		sx,sy = project_point(tx1,ty1,tz1)
		pset(sx,sy,6)
	end
end

k_bar_width=50
k_bar_start_x=4
k_bar_start_y=118
k_bar_height=6
function draw_hud()
	palt(0,true)
	spr(22,4,109,4,1)
	--rectfill(k_bar_start_x,k_bar_start_y,k_bar_start_x+k_bar_width,k_bar_start_y+k_bar_height,6)
	rectfill(2+k_bar_start_x,2+k_bar_start_y,k_bar_start_x+(k_bar_width-2)*max(0,player.health)/k_max_health,k_bar_start_y+k_bar_height-2,8)
	rect(k_bar_start_x,k_bar_start_y,k_bar_start_x+k_bar_width,k_bar_start_y+k_bar_height,7)
	palt()
end

-------- cut here --------
-- a little bit extended keyboard handler
-- detecting the onsets and releases of keys

-- @adam_sporka

-- is_held(k) is true if the key k is held down
-- is_pressed(k) is true if the key has just been pressed by the user
-- is_released(k) is true if the key has just been released by the user

keys={}

function is_held(k) return band(keys[k], 1) == 1 end
function is_pressed(k) return band(keys[k], 2) == 2 end
function is_released(k) return band(keys[k], 4) == 4 end

function upd_key(k)
	if keys[k] == 0 then
		if btn(k) then keys[k] = 3 end
	elseif keys[k] == 1 then
		if btn(k) == false then keys[k] = 4 end
	elseif keys[k] == 3 then
		if btn(k) then keys[k] = 1
		else keys[k] = 4 end
	elseif keys[k] == 4 then
		if btn(k) then keys[k] = 3
		else keys[k] = 0 end
	end
end

function init_keys()
	for a = 0,5 do keys[a] = 0 end
end

function upd_keys()
	for a = 0,5 do upd_key(a) end
end

---end button handler--

function center_text(text,x,y,c)
	x=x-#text/2*4
	print(text,x,y,1)
	print(text,x+1,y,1)
	print(text,x,y-1,1)
	print(text,x,y+1,1)
	
	
	print(text,x,y,c)
end

function draw_victory_screen()

		cls()
		
		
		
		palt(0,false)
		palt(14,true)
		
		
		srand(1)
		for i=1,40 do spr(137+flr(rnd(4)),(rnd(127)+cur_frame*.25)%127,(rnd(127)+cur_frame*.5)%127) end
		spr(128,32,65,9,8)
		
		center_text("victory!",64,5,10)
		
		center_text("kills: "..num_kills,64,25,11)
		center_text("misses: "..num_enemies-num_kills,64,35,11)
		center_text("percent: "..flr(((num_kills)/num_enemies)*100).."%",64,45,11)
		
		center_text("\x97: continue",64,122,7)

end
	
	object_list={}
	triangle_list={}
	
	function reset()
		for object in all(enemy_list) do
			delete_object(object)
		end
		for object in all(obst_list) do
			delete_object(object)
		end
		for object in all(player_shot_list) do
			delete_object(object)
		end
		player_shot_list={}
		
		level=0
		
		enemy_list={}
		obst_list={}

		player.faces=fox_f
		player_shadow.faces=sparrow_shadow_f
		
		player.x=0
		player.y=0
		player.z=0
		player.ax=0
		player.ay=0
		player.az=0
		
		player.vay=0
		player.vaz=0
		player.vax=0
		
		player.vx=0
		player.vy=0
		player.vz=0
		player.speed=1
		
		
		player.health=k_max_health
		player.dead=false
		
		player.distance=0
		player.last_distance=0
		
		cam_x=0
		cam_y=0
		cam_z=0
			
		map_column=0
		map_update_counter=0

		enemy_column=0
		enemy_populate_counter=0
		
		num_enemies=0
		num_kills=0
		
		ground_dot_list={}
	
	
		init_ground_dots()
		
		game_mode=k_title_mode
		music(0)
	end
	

function _init()
	cur_frame=0
	
	
	init_keys()

	

	obst_list={}
	
	
	
	
	
	shot_timeout=0
	
	player={}
	
	
	map_column=0
	map_update_counter=0

	enemy_column=0
	enemy_populate_counter=0
	enemy_list={}
	
	player_shot_list={}
	
	particle_list={}
		
	ground_dot_list={}
	
	new_player()
	new_ground()
	init_ground_dots()
	--populate_scenery()
	
	reset()
	
	title_ship=load_object(fox_v,fox_f) title_ship.ax=-.25 title_ship.az=0 title_ship.ay=0
	

	
end


function _update()
	upd_keys()
	
	if(game_mode==k_victory_mode)then

		if(btnp(5)) game_mode=k_title_mode music(0) reset()
	end
	if(game_mode==k_title_mode)then

		cam_x=0
		cam_y=-1
		cam_z=10
	
		title_ship.ay+=.003
		title_ship.az+=.004
		title_ship.ax+=.002
	
		generate_cam_matrix_transform(0,0,0)
		
		transform_object(title_ship)
		
		
		if(is_released(4))then
			game_mode=k_play_mode
			music(0)
			l=level+1
			
			ground.faces[1][4]=level_color[l][1]
			ground.faces[1][5]=level_color[l][2]
			ground.faces[2][4]=level_color[l][1]
			ground.faces[2][5]=level_color[l][2]
			
			ground.faces[3][4]=level_color[l][3]
			ground.faces[3][5]=level_color[l][4]
			ground.faces[4][4]=level_color[l][3]
			ground.faces[4][5]=level_color[l][4]
			
			for face in all(player_shadow.faces) do
				face[4]=level_color[l][1]
				face[5]=level_color[l][2]
			end
			
			--ground.faces[5][4]=level_color[l][3]
			--ground.faces[5][5]=level_color[l][4]
			--ground.faces[6][4]=level_color[l][3]
			--ground.faces[6][5]=level_color[l][4]
			
			delete_object(title_ship)
		end
		
	end
	
	if(game_mode==k_play_mode)then
		if(not player.dead)then
			handle_game_buttons()
			update_player()
			populate_scenery()
			populate_enemies()
		else
			player.z+=(cur_frame-player.dead_time)/60*3
			
		end
		
		update_enemies()
		update_shots()
		update_particles()
		
		check_collisions()

		update_ground()
		update_camera()
		update_ground_dots()


		for object in all(object_list) do
			--object.y=sin(cur_frame/60)*2
			if(object.ring)then
				object.az+=.01
				if(intersect_bounding_box(object, player))player.health=k_max_health
			end
			transform_object(object)
		end
	
		if(player.dead and cur_frame-player.dead_time>60)then

			reset()
			
		end
	
	end
	
	
	
	
end

function _draw()
	cur_frame+=1
	
	if(game_mode==k_victory_mode)draw_victory_screen()
	
	if(game_mode==k_title_mode)then
		cls()
		palt()
		triangle_list={}
		transform_object(title_ship)
		render_object(title_ship)
		
		srand(1)
		for i=1,40 do spr(137+flr(rnd(4)),(rnd(127)+cur_frame*.25)%127,(rnd(127)+cur_frame*.5)%127) end
		
		sort_triangle_list()
		draw_triangle_list()
		spr(48,0,0,15,5)
		
		palt(0,false)
		palt(14,true)
		
		spr(128,32,65,9,8)
		
		center_text("\x8e: start",64,40,11)
		
		
		
		center_text("\x8b"..level_list[level+1].."\x91",64,122,7)
		if(btnp(1)) level+=1 level%=#level_list 
		if(btnp(0)) level-=1 level%=#level_list  
		
	end
	
	if(game_mode==k_play_mode)then
		cls()
		
		rectfill(0,0,127,85,level_color[level+1][5])
		rectfill(0,85,127,127,level_color[level+1][6])		
		
		
		triangle_list={}
		render_object(ground)
		render_object(player_shadow)
		
		draw_triangle_list()
		render_ground_dots()
		triangle_list={}

		sort_object_list()
		for object in all(object_list) do
			if(object.visible and not object.background)render_object(object)
		end
		sort_triangle_list()
		draw_triangle_list()
		
		draw_hud()
	end

end
