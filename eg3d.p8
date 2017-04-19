pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--electric gryphon


--------------------------------------------------------------------------------------------------
--------------------------------------model definitions-------------------------------------------
--------------------------------------------------------------------------------------------------

--model definitions

--start with vector list: {x,y,z}
--and face list: {vertex1,vertex2,vertex3,color1,color2)
--face list numbers indicate the indeces of the vector list
--that make up the 3 corners of a triangle. if provided, the
--4th and 5th index are used to hold the two colors that make
--up the faces composite color. this is only necessary if you
--want to overide the shaded monochromatic color options.

--i have a series of find/replaces that converts an obj format
--exported from blender into these lists. if someone is in the
--mood to write a conversion scrip that would be really awesome.

fox_v_string="fe7106e700c6fec605aeffebfe1404b600d8fe6605e001f9fe710734027dfe4404b701b1ff8b0a06ffabff0b099affedff870a590009ff1b0a7f0055ff3d03c6fd3dfedd0350fdbdff2004dbfe4403060356fda9027d0504fdf4029a04a7ffc5fd5d0041fdf7fd0100ccfefbfd4000e7fd49feb102d6fd21fe2101d9fe0afded028afe43fe9d03acffb9feda048effb8fdf408580070fe9b08b7ffeffefa073e0022fe6403060010fe98039a0038fed8028bff84fe5b022e008afe2c0344012bfd1b0162fe5ffd7509720219fdd50a210283fe5d0a870114fc8f081b016dfc3608fb01c4029f0154fd2702ba02cbfce9fdb00947010d004d0a860072013d09ac01b5015508a100af01e905af002cfdb90110fc4600430775ffbdff36086effccfdbb09ec00e5005e069cff2d012006acffd000fa05ecfdbefdbf005ffc21fe9300d0fb63ff05033ffcd5034d0271ff3203360143fd73ff600bb0ffd6ff550bd70064ff6c0aef012400560a970157000609a3ffe3015f0484fc970007050bfd1dffc70acbffd1ffce06c0ff77fdc7008dfc96feaa03daff3cfda401c0fff2fd96011f000eff440272fc65ff090585ff69ffac061eff0e01d0061a00da017e06ce00affe0b07b80232fdbc07f20102021f007afc8e01050051fb7f01cd0278fbeefe2701d4ff6afd84019efeaafea201bdfd13fd360054ff40fec5032efe91033a0116ff22ff7903a5fcfdfe6801acfc32fd9c016dfd6301a8072f015afc9908430266ff870168fc77fef90aef00df012103dffc3afea0053c027e005502ecfbf9ffff00e9fb2401a300e000ad020f0053012a024d005f0018ffa6009d02ccffaf00b8017cfee100ce0195fe9400e3007dfe8d00ee0124fe8901fd012eff7c0b7c03dbffe20a5203d600460ad1033200dc0816030bffaf09ca03d0ff3f09d70333fef608c203c4ff71093c03acfe3c08570313fee5fffd027afe4d00920213009d014afbae011d08e3029600dc076402cdfeae026f019fff8f01b50166ffd7031b0199002103c80234ffdb00f00219006e00d80249ff3f0aa9034bffa40a4e036f029603370018015c025100e8026f021100f8fdc80093fff7012b01c301d900e903a6026f0116005b0151032f02210007007206a402e0ffb707e70375ff62050702f6fde0092d02a801f7051800f900df04f902e6017a044801fffdb7002701beff5b0ab40236ff690bb70361ffd10052fb3aff6104160230ff1e0a8a028bfd75fffcff59fd48fffcff2afd59fffcfe94fdd0fffc0193fe03fffc015dfdddfffc01f2fee1fffc0276feb6fffc008ffec4fffcfbe4fe1cfffc022bfee2fffc02790257fffcfd84021afffc00c1023ffffcfd44026cfffcff880024fffc02efff72fffc0311ffdffffcfb6c0272fffcfdd2026dfffcfd8e02a1fffcff2bfdadfffcfceefd82fffcfda9fe3dfffcfc20fe6afffcfc08fe7dfffc006afe05fffc01410093fffc016f004bfffc02dc0060fffcfb88fe93fffcfc030179fffcfc2000cffffc013c011dfffcfbc101a1fffc0138fee4fffc0274fee8fffc0266fee9fffc026afeeafffc026ffef1fffc02870203fffc0129"

fox_f_string="01020301040504010306040307080909080a0b0c0d0e0f10111213141516170218191a1b1c1d1e1f201c21131222232425261927280e291a192a2b2c2d100f2e13212f1b30222431323334342d0f352e360c0b370e3839280f0e332d342a3a3b2a3c3d072a3e3e08073f40342a413a1926291b2f42400b0d35432e4417180a4109412a07451246470b40481b49021b484a2d4b014c4d3e30084e4f50270e39511c1e5115521e16511553525412111e4455284e5038563947570b160c144551521c2003200603322f333a410a582e59525859312408262229223129493234400d4902011b48490d2c2f3e2c5a4b4b332c1848441a301b01191b5b262532422f254d4c3d2b2a503f280c16550d44483e2f30440c55475c531453152152595116154b2d3303021717441e171e1d1c031d31081a301a081b4249014d1955161e180248332f2c4934405d3a0a3249424d25194c01053f340f3b3c2a2a2c3e29311a505e3f375747431113351143240a082112455f040628274e604740440d0c57370b475314471437525358461c45592e21140c3743132e283f0f4552215d3b3a171d03245d0a451c5161585361535c626364656667681f46696a686b6c6d6e6c6f707172057173746775766050776e78797a7b7c7d7e7f7080686a1f697567362e58380e10677a7969676a1f1c468182838468467e8586667a675b254c8782858883648446126774657d657e657d66898a8b058a715b738c8d5a8e775a2b108d818c232286858f857e87586136868f8e6287638287625688647569905e6040045f8b91926d7170238d828180706f614f9389788a8a058b8183886c6b802b6d6c6e728a828d8f56388894067b79206a7d7a66504f760941072b5a2c2391243d916d9123953d6d2b3d3c9171238c8c225b3881886b6d92957f6b956b9270726f6c806f6c6e776f726e7f9570952370718c738a786e8a72718b5f94867c7e764f61772b6c24915d5b4c735b2226785a778e5a894b5a4a5a8d4a8d2d4a8b05041254848f858247605c7b7d7c5d3c3b8382626a201f7b06790620796b7f80913c5d78895a06945f8e898b7c8e8b10813864836260765c8d8e8f947b7c8e7c86947c8b7b7a7d67796a5c76614c0573403f5e5e50602d8d10959291a09f9cb5b74fb54f4ea1a34ea14e27a9a127a92739989754985411aead35ae3536a79e93abac11ab1135a8a939a83956aaa856a3b54eac9811af9d68af6884bda665bd65749b9f759b7590a6a565b6b8879796849784549db068a2a464b09a69b06968b2b17e9a99909a90699fa0749f7475b3a793b3934f9eb4619e6193bea264be6463b4ae36b43661a4aa56a45664b1b687b1877e96af84999b90a5b27ea57e65b8be63b86387a09c74babb749cb974b9ba74adab35b7b34fbcbd74bbbc74"

pyramid_v_string="0000fdf0fc000376fdf00200000003970000fc89fdf00200"

pyramid_f_string="020304010302040301010204"

column_v_string="fe00fffd0200fe00fffdfe000200fffdfe000200fffd0200fe0001140200fe000114fe0002000114fe00020001140200fef5029c010afef5029cfef5010a029cfef5010a029c010a0000103c0179fe86103c00000000103cfe860179103c0000000011580289fd761158000000001158fd76028911580000"

column_f_string="06020107030208040305010405080c100d0c08070b07060a0605091014110f100b0e0f0a0d0e090f13140e12130d11120d090c100c0b0f0b0a0e0a0905060106070207080308050409050c0c080b0b070a0a06090d1011100f140f0e130e0d12"

hole_v_string="0240fdc0fdc00240fdc00240fdc0fdc00240fdc0fdc0fdbf02400240fdc0023f02400240fdbf0240023ffdc00240fdc001200240fee0011f02400120fee002400120fee00240fee00120fdc0fee00120fdc00120fee0fdc00120fee0fdc0fedf"

hole_f_string="030410070b0c0105060206070708040104080b0a0e060a0b080c0905090a090d0e030f0e010d10020e0d100d090b0f100f031008070c0201060302070307040501080f0b0e07060b05080906050a0a090e02030e04011001020d0c10090c0b10"


fountain_v_string="000000d1fe80000002a7fe80016d00d1ff89016d02a7ff8900e100d1013600e102a70136ff1e00d10136ff1e02a70136fe9200d1ff89fe9202a7ff890000045afc0b03c3045afec60253045a0333fdac045a0333fc3c045afec60000055ffc0b03c3055ffec60253055f0333fdac055f0333fc3c055ffec60000000efd74026b000eff36017e000e020ffe81000e020ffd94000eff36"


fountain_f_string="0204030406050608070a0f0b0a0201080a090115190f1410080e0f060d0e040c0d020b0c1110140e13140d12130c11120b1011091918050718030517031615010203030405050607020a0b090a010708090901190b0f100a080f08060e06040d04020c1312111311140e0d130f0e140d0c120c0b11070918170518160317010315"

factory_v_string="02befffbfd3202befffb02cdfd24fffb02cdfd24fffbfd3202be0315fd3202be031502cdfd24059502cdfd240595fd32fe8e04f30083fe8e04f3ff7cff94047dff7cff94047d0083fe8e06550083fe8e0655ff7cff94070aff7cff94070a00830027043e00830027043eff7c012d03c7ff7c012d03c700830027059f00830027059fff7c012d0655ff7c012d06550083"

factory_f_string="1314060105060206070708040104080e0a090f0b0a100c0b100d090f0e0d16121117131218141318151118171611120b0201060302070307040501080d0e090e0f0a0f100b0c1009100f0d151611161712171813141811151816090a080a13050614090513060c110b070908080a05070609"

tower_v_string="01a2053c01a201a2053cfe5dfe5d053cfe5dfe5d053c01a2029effff029e029efffffd61fd61fffffd61fd61ffff029e01a2084601a201a20846fe5dfe5d0846fe5dfe5d084601a2ff0008d20100ff0008d2ff00010008d2ff00010008d20100ff000ad20100ff000ad2ff0001000ad2ff0001000ad20100ff5e0c1200a1ff5e0c12ff5e00a10c12ff5e00a10c1200a1ff5e0d5600a1ff5e0d56ff5e00a10d56ff5e00a10d5600a1"

tower_f_string="040c0b0408050105060206070307080a0b0c030b0a020a0901090c120e0d130f0e14100f110d100e0f101312111a16151b17161c18171915181617181b1a1903040b010405020106030207040308090a0c02030a01020904010c11120d12130e13140f1411100d0e10141311191a151a1b161b1c171c19181516181c1b19"
------------------------------------------------------------begin hex string data handling--------------------------------

hex_string_data = "0123456789abcdef"
char_to_hex = {}
for i=1,#hex_string_data do
	char_to_hex[sub(hex_string_data,i,i)]=i-1
end

function read_byte(string)
	return char_to_hex[sub(string,1,1)]*16+char_to_hex[sub(string,2,2)]
end

function read_2byte_fixed(string)
	local a=read_byte(sub(string,1,2))
	local b=read_byte(sub(string,3,4))
	local val =a*256+b
	return val/256
end

cur_string=""
cur_string_index=1
function load_string(string)
	cur_string=string
	cur_string_index=1
end

function read_vector()
	v={}
	for i=1,3 do
		text=sub(cur_string,cur_string_index,cur_string_index+4)
		value=read_2byte_fixed(text)
		v[i]=value
		cur_string_index+=4
	end
	return v
end

function read_face()
	f={}
	for i=1,3 do
		text=sub(cur_string,cur_string_index,cur_string_index+2)
		value=read_byte(text)
		f[i]=value
		cur_string_index+=2
	end
	return f
end		

function read_vector_string(string)
	vector_list={}
	load_string(string)
	while(cur_string_index<#string)do
		vector=read_vector()
		add(vector_list,vector)
	end
		return vector_list
end

function read_face_string(string)
	face_list={}
	load_string(string)
	while(cur_string_index<#string)do
		face=read_face()
		add(face_list,face)
	end
		return face_list
end
------------------------------------------------------------end hex string data handling--------------------------------


-------------------------------------------------------------begin cut here-------------------------------------------------
------------------------------------------------------electric gryphon's 3d library-----------------------------------------
----------------------------------------------------------------------------------------------------------------------------

k_color1=4
k_color2=5

k_screen_scale=80
k_x_center=64
k_y_center=64



z_clip=-3
z_max=-50

k_min_x=0
k_max_x=128
k_min_y=0
k_max_y=128


k_ambient=.3


light1_x=.1
light1_y=.35
light1_z=.2

--t_light gets written to
t_light_x=0
t_light_y=0
t_light_z=0



k_colorize_static = 1
k_colorize_dynamic = 2
k_multi_color_static = 3
k_multi_color_dynamic = 4
k_preset_color = 5

k_friction=.7

--these are used for the 2 scanline color shading scheme
double_color_list=	{{0,0,0,0,0,0,0,0,0,0},
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
					}


function delete_object(object)
	del(object_list,object)
end

function new_object()
	printh ("BEGIN_NEW_OBJECT")
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
	printh ("END_NEW_OBJECT")
	return object

end

function new_triangle(p1x,p1y,p2x,p2y,p3x,p3y,z,c1,c2)

	printf("BEGIN_NEW_TRIANGLE");
	
	add(triangle_list,{p1x=p1x,
	                   p1y=p1y,
	                   p2x=p2x,
	                   p2y=p2y,
	                   p3x=p3x,
	                   p3y=p3y,
	                   tz=z,
	                   c1=c1,
	                   c2=c2})
	
	--~ printh ("p1x: " .. (p1x));
	--~ printh ("p1y: " .. (p1y));
	--~ printh ("p2x: " .. (p2x));
	--~ printh ("p2y: " .. (p2y));
	--~ printh ("p3x: " .. (p3x));
	--~ printh ("p3y: " .. (p3y));
	--~ printh ("tz : " .. (tz ));
	--~ printh ("c1 : " .. (c1 ));
	--~ printh ("c2 : " .. (c2 ));
	
	printh ("END_NEW_TRIANGLE");
	
end



function init_player()
	printh ("BEGIN_INIT_PLAYER")
	player=new_object()
	player.min_x=-4.5
	player.min_y=-4.5
	player.min_z=-4.5
	player.max_x=4.5
	player.max_y=4.5
	player.max_z=4.5
	
	player.x=0
	player.y=8
	player.z=15
	
	player.vx=0
	player.vy=0
	player.vz=0
	
	--~ printh ("player.min_x: " .. (player.min_x))
	--~ printh ("player.min_y: " .. (player.min_x))
	--~ printh ("player.min_z: " .. (player.min_x))
	--~ printh ("player.max_x: " .. (player.max_x))
	--~ printh ("player.max_y: " .. (player.max_y))
	--~ printh ("player.max_z: " .. (player.max_z))
	--~ printh ("player.x: " .. (player.x))
	--~ printh ("player.y: " .. (player.y))
	--~ printh ("player.z: " .. (player.z))
	--~ printh ("player.ax: " .. (player.ax))
	--~ printh ("player.ay: " .. (player.ay))
	--~ printh ("player.az: " .. (player.az))
	--~ printh ("player.vx: " .. (player.vx))
	--~ printh ("player.vy: " .. (player.vy))
	--~ printh ("player.vz: " .. (player.vz))
	printh ("END_INIT_PLAYER")
end

function normalize(x,y,z)
	printh("BEGIN_NORMALIZE")
	local x1=shl(x,2)
	local y1=shl(y,2)
	local z1=shl(z,2)
	
	local inv_dist=1/sqrt(x1*x1+y1*y1+z1*z1)
	
	printh("END_NORMALIZE")
	return x1*inv_dist,y1*inv_dist,z1*inv_dist
	
end

function init_light()

	printh ("BEGIN_INIT_LIGHT")
	--~ printh ("prelight1_x: " .. (light1_x))
	--~ printh ("prelight1_y: " .. (light1_y))
	--~ printh ("prelight1_z: " .. (light1_z))
	light1_x,light1_y,light1_z=normalize(light1_x,light1_y,light1_z)
	--~ printh ("light1_x: " .. (light1_x))
	--~ printh ("light1_y: " .. (light1_y))
	--~ printh ("light1_z: " .. (light1_z))
	printh ("END_INIT_LIGHT")
end

function init_3d()
	printh ("BEGIN_INIT_3D")
	init_light()
	object_list={}
	obstacle_list={}
	
	init_player()
	
	particle_list={}
	printh ("END_INIT_3D")
end


function load_scene(init_func,update_func,background_func)
	printh("BEGIN_LOAD_SCENE")
	scene_update_func=update_func
	scene_background_function=background_func
	init_3d()
	init_func()
	printh("END_LOAD_SCENE")
end

function init_stars()
	printh("BEGIN_INIT_STARS")
	star_list={}
	for i=1,150 do
		star_list[i]={}
		star_list[i].x=rnd(508)
		star_list[i].y=rnd(55)
	end
	printh("END_INIT_STARS")
end
	


--function load object:
--object_vertices: vertex list for object (see above)
--object_faces: face list for object (see above)
--x,y,z: translated center for the the object
--ax,ay,az: rotation of object about these axis
--obstacle: boolean will the player collide with this?
--color mode:
--k_colorize_static = 1 : shade the model at init with one shaded color
--k_colorize_dynamic = 2 : color the model dynamically with one shade color -- slow
--k_multi_color_static = 3 : shade the model based on colors defined in face list
--k_multi_color_dynamic = 4 : shade the model dynamically based on colors define din face list -- slow
--k_preset_color = 5 : use the colors defined in face list only -- no lighting effects












function	cross_product_2d(p0x,p0y,p1x,p1y,p2x,p2y)
	return ( ( (p0x-p1x)*(p2y-p1y)-(p0y-p1y)*(p2x-p1x)) > 0 )
end







function lerp(a,b,alpha)
  return a*(1.0-alpha)+b*alpha
end








----------------------------------end copy-------------------------------------------------------
----------------------------------electric gryphon's 3d library----------------------------------
-------------------------------------------------------------------------------------------------


function center_text(text,x,y,c)
	x=x-#text/2*4
	print(text,x,y,1)
	print(text,x+1,y,1)
	print(text,x,y-1,1)
	print(text,x,y+1,1)
	
	
	print(text,x,y,c)
end

function draw_background()
	rectfill(0,0,127,64,14)
	draw_stars()

	
	rectfill(0,64,127,127,5)
	
	for i=0,2 do
		rectfill(0,66+i*2,127,66+i*2,6)
		rectfill(0,60-i*2,127,60-i*2,15)
	end
end





function start_timer()
	timer_value=stat(1)
end

function stop_timer()
	return stat(1)-timer_value
end

function load_factory()
	factory_data={}
	for i=-2,2 do
		factory_data[i]={}
		for j=-2,2 do
			--if(rnd(1)>.5)then v=1 else v=2 end
			factory_data[i][j]=1
		end
	end
	--factory_data[0][0]=0
	--factory_data[1][0]=2
	--factory_data[-1][0]=2
	--factory_data[0][1]=2
	--factory_data[0][-1]=2
	

	

	player.x=10
	player.z=10
	for i=-2,2 do
		for j=-2,2 do
			
				if(factory_data[i][j]==1)load_object(read_vector_string(factory_v_string),read_face_string(factory_f_string),i*20,0,j*20,0,0,0,true,k_colorize_static,6)
				if(factory_data[i][j]==2)load_object(read_vector_string(tower_v_string),read_face_string(tower_f_string),i*20,0,j*20,0,0,0,true,k_colorize_static,6)
				
			
		end
	end
	
	clouds={}
	for i=1,10 do
		clouds[i]={}
		clouds[i].x=rnd(160)-15
		clouds[i].y=rnd(160)-15
	end
end


function update_factory()
	if(player.x>10)player.x-=20 
	if(player.x<-10)player.x+=20
	if(player.z>10)player.z-=20
	if(player.z<-10)player.z+=20

end

function draw_factory_background()
	cls(1)
	
	srand(1)
	
	for cloud in all(clouds) do
		circfill((cloud.x-player.ay*400)%127,cloud.y,15,13)
		cloud.y-=1
		if(cloud.y<-15)then cloud.y=127 end
	end
	
	rectfill(0,64,127,127,13)

end

function load_fox_dynamic()
	fox_v=read_vector_string(fox_v_string)
	fox_f=read_face_string(fox_f_string)
	fox=load_object(fox_v,fox_f,0,0,0,0,-.35,0,false,k_colorize_dynamic,8)
end

function update_fox_dynamic()
	fox.ay+=.01
end

function init_stars()
	printh("BEGIN_INIT_STARS")
	star_list={}
	for i=1,150 do
		star_list[i]={}
		star_list[i].x=rnd(508)
		star_list[i].y=rnd(55)
	end
	printh("END_INIT_STARS")
end

function generate_matrix_transform(xa,ya,za)

	
	printh ("BEGIN_GMT")
	
	local sx=sin(xa)
	local sy=sin(ya)
	local sz=sin(za)
	local cx=cos(xa)
	local cy=cos(ya)
	local cz=cos(za)
	
	
	--~ printh ("sx: " .. sx)
	--~ printh ("sy: " .. sy)
	--~ printh ("sz: " .. sz)
	--~ printh ("cx: " .. cx)
	--~ printh ("cy: " .. cy)
	--~ printh ("cz: " .. cz)
	
	mat00=cz*cy
	mat10=-sz
	mat20=cz*sy
	mat01=cx*sz*cy+sx*sy
	mat11=cx*cz
	mat21=cx*sz*sy-sx*cy
	mat02=sx*sz*cy-cx*sy
	mat12=sx*cz
	mat22=sx*sz*sy+cx*cy

	--~ printh ("mat00: " .. mat00)
	--~ printh ("mat10: " .. mat10)
	--~ printh ("mat20: " .. mat20)
	--~ printh ("mat01: " .. mat01)
	--~ printh ("mat11: " .. mat11)
	--~ printh ("mat21: " .. mat21)
	--~ printh ("mat02: " .. mat02)
	--~ printh ("mat12: " .. mat12)
	--~ printh ("mat22: " .. mat22)
	printh ("END_GMT")
end

function generate_cam_matrix_transform(xa,ya,za)

	printh ("BEGIN_CAM_GMT")
	
	local sx=sin(xa)
	local sy=sin(ya)
	local sz=sin(za)
	local cx=cos(xa)
	local cy=cos(ya)
	local cz=cos(za)
	
	--~ printh ("sx: " .. sx)
	--~ printh ("sy: " .. sy)
	--~ printh ("sz: " .. sz)
	--~ printh ("cx: " .. cx)
	--~ printh ("cy: " .. cy)
	--~ printh ("cz: " .. cz)
	
	cam_mat00=cz*cy
	cam_mat10=-sz
	cam_mat20=cz*sy
	cam_mat01=cx*sz*cy+sx*sy
	cam_mat11=cx*cz
	cam_mat21=cx*sz*sy-sx*cy
	cam_mat02=sx*sz*cy-cx*sy
	cam_mat12=sx*cz
	cam_mat22=sx*sz*sy+cx*cy

	--~ printh ("cam_mat00: " .. cam_mat00)
	--~ printh ("cam_mat10: " .. cam_mat10)
	--~ printh ("cam_mat20: " .. cam_mat20)
	--~ printh ("cam_mat01: " .. cam_mat01)
	--~ printh ("cam_mat11: " .. cam_mat11)
	--~ printh ("cam_mat21: " .. cam_mat21)
	--~ printh ("cam_mat02: " .. cam_mat02)
	--~ printh ("cam_mat12: " .. cam_mat12)
	--~ printh ("cam_mat22: " .. cam_mat22)

	printh ("END_CAM_GMT")
end

function rotate_point(x,y,z)
	
	printh ("BEGIN_ROTATE_POINT")
	--~ printh ("in0: " .. ( x))
	--~ printh ("in1: " .. ( y))
	--~ printh ("in2: " .. ( z))
	
	--~ printh ("mat00: " .. (mat00));
	--~ printh ("mat10: " .. (mat10));
	--~ printh ("mat20: " .. (mat20));
	--~ printh ("mat01: " .. (mat01));
	--~ printh ("mat11: " .. (mat11));
	--~ printh ("mat21: " .. (mat21));
	--~ printh ("mat02: " .. (mat02));
	--~ printh ("mat12: " .. (mat12));
	--~ printh ("mat22: " .. (mat22));
	
	--~ printh ("out0: " .. ((x)*mat00+(y)*mat10+(z)*mat20))
	--~ printh ("out1: " .. ((x)*mat01+(y)*mat11+(z)*mat21))
	--~ printh ("out2: " .. ((x)*mat02+(y)*mat12+(z)*mat22))
	printh ("END_ROTATE_POINT")

	return (x)*mat00+(y)*mat10+(z)*mat20,(x)*mat01+(y)*mat11+(z)*mat21,(x)*mat02+(y)*mat12+(z)*mat22
end

function transform_object(object)
	
		printh ("BEGIN_TRANSFORM_OBJ")
	
	if(object.visible)then
		--~ printh ("object.visible: 1")
		
		
		--~ printh ("object.ax: " .. object.ax)
		--~ printh ("object.ay: " .. object.ay)
		--~ printh ("object.az: " .. object.az)
		generate_matrix_transform(object.ax,object.ay,object.az)
		for i=1, #object.vertices do
			local t_vertex=object.t_vertices[i]
			local vertex=object.vertices[i]
			
			t_vertex[1],t_vertex[2],t_vertex[3]=rotate_point(vertex[1],vertex[2],vertex[3])
		end
	else
		--~ printh ("object.visible: 0")
	end
		printh ("END_TRANSFORM_OBJ")
end

function set_radius(object)
	printh ("BEGIN_SET_RADIUS")
	for vertex in all(object.vertices) do
		object.radius=max(object.radius,vertex[1]*vertex[1]+vertex[2]*vertex[2]+vertex[3]*vertex[3])
		--~ printh ("object.radius: " .. (object.radius))
	end
	object.radius=sqrt(object.radius)
		--~ printh ("object.radius: " .. (object.radius))
	printh ("END_SET_RADIUS")
end

function set_bounding_box(object)
	printh ("BEGIN_SET_BOUNDING_BOX")
	for vertex in all(object.t_vertices) do
		object.min_x=min(vertex[1],object.min_x)
		object.min_y=min(vertex[2],object.min_y)
		object.min_z=min(vertex[3],object.min_z)
		object.max_x=max(vertex[1],object.max_x)
		object.max_y=max(vertex[2],object.max_y)
		object.max_z=max(vertex[3],object.max_z)
		--~ printh ("vertex[0]: " .. (vertex[1]))
		--~ printh ("vertex[1]: " .. (vertex[2]))
		--~ printh ("vertex[2]: " .. (vertex[3]))
		--~ printh ("object.min_x: " .. (object.min_x))
		--~ printh ("object.min_y: " .. (object.min_y))
		--~ printh ("object.min_z: " .. (object.min_z))
		--~ printh ("object.max_x: " .. (object.max_x))
		--~ printh ("object.max_y: " .. (object.max_y))
		--~ printh ("object.max_z: " .. (object.max_z))
	end

	printh ("END_SET_BOUNDING_BOX")
end

function	vector_cross_3d(px,py,pz,ax,ay,az,bx,by,bz)

	printh("BEGIN_VECTOR_CROSS_3D")
	 ax-=px
	 ay-=py
	 az-=pz
	 bx-=px
	 by-=py
	 bz-=pz
	
	--~ printh("ax: " .. (ax))
	--~ printh("ay: " .. (ay))
	--~ printh("az: " .. (az))
	--~ printh("bx: " .. (bx))
	--~ printh("by: " .. (by))
	--~ printh("bz: " .. (bz))
	
	local dx=ay*bz-az*by
	local dy=az*bx-ax*bz
	local dz=ax*by-ay*bx
	
	--~ printh("nx: " .. (dx))
	--~ printh("ny: " .. (dy))
	--~ printh("nz: " .. (dz))
	
	
	printh("END_VECTOR_CROSS_3D")
	
	
	return dx,dy,dz
end

function	vector_dot_3d(ax,ay,az,bx,by,bz)

	printh("BEGIN_VECTOR_DOT_3D")
	--~ printh("vd3d: " .. (ax*bx+ay*by+az*bz))
	
	
	printh("END_VECTOR_DOT_3D")
	return ax*bx+ay*by+az*bz
end
			
function color_shade(color,brightness)
	printh ("BEGIN_COLOR_SHADE")
	--return double_color_list[ (color+1)*2-1 ][flr(brightness*10)] , double_color_list[ (color+1)*2 ][flr(brightness*10)] 
	local b= band(brightness*10,0xffff)
	local c= (color+1)*2
	
	printh("b: "  .. b )
	printh("color: "  .. color )
	printh("brightness: "  .. brightness )
	--~ printh("c: "  .. c )
	--~ printh("f4: " .. (double_color_list[ c-1 ][b]))
	--~ printh("f5: " .. (double_color_list[ c ][b]))
	
	printh ("END_COLOR_SHADE")
	return double_color_list[ c-1 ][b] , double_color_list[ c ][b] 
end		

function color_faces(object,base)
	printh("BEGIN_COLOR_FACES")
	--local p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z
	
		
		for i=1,#object.faces do
			local face=object.faces[i]
		--for face in all(object.faces)do
			local p1x=object.t_vertices[face[1]][1]
			local p1y=object.t_vertices[face[1]][2]
			local p1z=object.t_vertices[face[1]][3]
			local p2x=object.t_vertices[face[2]][1]
			local p2y=object.t_vertices[face[2]][2]
			local p2z=object.t_vertices[face[2]][3]
			local p3x=object.t_vertices[face[3]][1]
			local p3y=object.t_vertices[face[3]][2]
			local p3z=object.t_vertices[face[3]][3]		
		
		
	
			local nx,ny,nz = vector_cross_3d(p1x,p1y,p1z,
								p2x,p2y,p2z,
								p3x,p3y,p3z)

	
		nx,ny,nz = normalize(nx,ny,nz)
		local b = vector_dot_3d(nx,ny,nz,light1_x,light1_y,light1_z)
		--see how closely the light vector and the face normal line up and shade appropriately
		
		-- print(nx.." "..ny.." "..nz,10,i*8+8,8) 
		-- flip()
		if(object.color_mode==k_multi_color_dynamic)then
			face[4],face[5]=color_shade(object.base_faces[i][4], mid( b,0,1)*(1-k_ambient)+k_ambient )
		else
			face[4],face[5]=color_shade(base, mid( b,0,1)*(1-k_ambient)+k_ambient )
		end
	end
	
	printh("END_COLOR_FACES")
end	

function load_object(object_vertices,object_faces,x,y,z,ax,ay,az,obstacle,color_mode,color)
	
	printh ("BEGIN_LOAD_OBJECT")
	
	object=new_object()
	
 	--~ printh ("object.num_faces: " .. #object_faces)
 	--~ printh ("object.num_vertices: " .. #object_vertices)
 	--~ printh ("object.x: " .. object.x)
 	--~ printh ("object.y: " .. object.y)
 	--~ printh ("object.z: " .. object.z)
 	--~ printh ("object.rx: " .. object.rx)
 	--~ printh ("object.ry: " .. object.ry)
 	--~ printh ("object.rz: " .. object.rz)
 	--~ printh ("object.tx: " .. object.tx)
 	--~ printh ("object.ty: " .. object.ty)
 	--~ printh ("object.tz: " .. object.tz)
 	--~ printh ("object.ax: " .. object.ax)
 	--~ printh ("object.ay: " .. object.ay)
 	--~ printh ("object.az: " .. object.az)
 	--~ printh ("object.sx: " .. object.sx)
 	--~ printh ("object.sy: " .. object.sy)
 	--~ printh ("object.color: " .. color)
 	--~ printh ("object.color_mode: " .. color_mode)
 	--~ printh ("object.radius: " .. object.radius)
 	--~ printh ("object.sradius: " .. object.sradius)
 	
 	--~ printh ("object.obstacle: " .. 0)
 	--~ printh ("object.visible: " .. 1)
 	--~ printh ("object.render: " .. 1)
 	--~ printh ("object.background: " .. 0)
 	--~ printh ("object.collision_x: " .. 1)
 	--~ printh ("object.collision_y: " .. 0)
 	--~ printh ("object.collision_down: " .. 0)
 	--~ printh ("object.collision_up: " .. 0)
 	--~ printh ("object.collision_left: " .. 0)
 	--~ printh ("object.ring: " .. 0)
 	
 	--~ printh ("object.min_x: " .. object.min_x)
 	--~ printh ("object.min_y: " .. object.min_y)
 	--~ printh ("object.min_z: " .. object.min_z)
 	--~ printh ("object.max_x: " .. object.max_x)
 	--~ printh ("object.max_y: " .. object.max_y)
 	--~ printh ("object.max_z: " .. object.max_z)
 	--~ printh ("object.vx: " .. object.vx)
 	--~ printh ("object.vy: " .. object.vy)
 	--~ printh ("object.vz: " .. object.vz)
 	--~ printh ("object.age: " .. object.age)
 	--~ printh ("object.health: " .. object.health)
	
	object.vertices=object_vertices

	--make local deep copy of translated vertices
	--we share the initial vertices
	for i=1,#object_vertices do
			for j=1,3 do
				--~ printh ("ivert[" .. (i - 1) .. "][" .. (j - 1) .. "]: " .. object_vertices[i][j])
				--~ printh ("overt[" .. (i - 1) .. "][" .. (j - 1) .. "]: " .. object.vertices[i][j])
			end
	end

	--make local deep copy of translated vertices
	--we share the initial vertices
	for i=1,#object_vertices do
		object.t_vertices[i]={}
			for j=1,3 do
				object.t_vertices[i][j]=object.vertices[i][j]
				--~ printh ("itvert[" .. (i - 1) .. "][" .. (j - 1) .. "]: " .. object_vertices[i][j])
				--~ printh ("otvert[" .. (i - 1) .. "][" .. (j - 1) .. "]: " .. object.t_vertices[i][j])
			end
	end
	
	--make local deep copy of faces 
	--if we don't car about on-demand shading we can share faces
	--but it means that objects will look wrong when rotated
	
	if(color_mode==k_preset_color)then
		object.faces=object_faces
		--for debug
	else
		object.base_faces=object_faces
		object.faces={}
		for i=1,#object_faces do
			object.faces[i]={}
			for j=1,#object_faces[i] do
				object.faces[i][j]=object_faces[i][j]
			end
		end
	end

		for i=1,#object_faces do
			for j=1,#object_faces[i] do
				--~ printh ("iface[" .. (i - 1) .. "][" .. (j - 1) .. "]: " .. (object_faces[i][j]-1))
			end
		end
	
	object.radius=0
	


	object.ax=ax or 0
	object.ay=ay or 0
	object.az=az or 0
	--~ printh ("object.ax: " .. (object.ax))
	--~ printh ("object.ay: " .. (object.ay))
	--~ printh ("object.az: " .. (object.az))
	
	transform_object(object)
	
	set_radius(object)
	set_bounding_box(object)
	
	object.x=x or 0
	object.y=y or 0
	object.z=z or 0
	--~ printh ("object.x: " .. (object.x))
	--~ printh ("object.y: " .. (object.y))
	--~ printh ("object.z: " .. (object.z))
	
	object.color = color or 8
	object.color_mode= color_mode or k_colorize_static
	object.obstacle = obstacle or false
	--~ printh ("object.color: " .. (object.color))
	--~ printh ("object.color_mode: " .. (object.color_mode))
	
	if(obstacle)add(obstacle_list,object)
	
	if(color_mode==k_colorize_static or color_mode==k_colorize_dynamic or color_mode==k_multi_color_static )then
		color_faces(object,color)
	end
	
	printh ("END_LOAD_OBJECT")
	
	return object
end

function load_temple()
	printh("BEGIN_LOAD_TEMPLE")
	
	init_stars()

	--~ for i=1,5 do
		--~ l=30
		--~ x=sin(i/5)*l
		--~ z=cos(i/5)*l
		--~ --printh ("x: " .. (x))
		--~ --printh ("i: " .. (i))
		--~ --printh ("l: " .. (l))
		--~ c=load_object(read_vector_string(column_v_string),read_face_string(column_f_string),x,0,z,0,0,0,true,k_colorize_static,9)--load models
	--~ end
	
	--~ fnt=load_object(read_vector_string(fountain_v_string),read_face_string(fountain_f_string),0,0,0,0,.08,0,true,k_colorize_static,14)
	hole=load_object(read_vector_string(hole_v_string),read_face_string(hole_f_string),0,11,0,.125,.125,.125,false,k_colorize_dynamic,12)
		
	--~ pyramids={}
	--~ for i=1,5 do
		--~ l=25
		--~ a=i/5+.125
		--~ x=sin(a)*l
		--~ z=cos(a)*l
		--~ pyramids[i]=load_object(read_vector_string(pyramid_v_string),read_face_string(pyramid_f_string),x,0,z,0,0,0,false,k_colorize_static,13)
	--~ end
	
	printh("END_LOAD_TEMPLE")
end

function update_temple()
	printh("BEGIN_UPDATE_TEMPLE")
	hole.ay+=-.004 --dynamically adjust object parameters to make them move each frame
	hole.az+=.001
	hole.ax+=.002
	hole.y=11+sin(cur_frame/100)
	
	--~ for i=1,5 do
		--~ l=35
		--~ a=i/5+.125+cur_frame/1000
		--~ x=sin(a)*l
		--~ z=cos(a)*l
		--~ pyramids[i].x=sin(a)*l pyramids[i].z=cos(a)*l
		--~ pyramids[i].y=10+sin(a-cur_frame/200)*4
		--~ pyramids[i].ax+=.003 pyramids[i].ay+=.002 pyramids[i].az+=.004
	--~ end
	printh("END_UPDATE_TEMPLE")
end

function draw_stars()
	printh("BEGIN_DRAW_STARS")
	for i=1,#star_list do
		pset((-cam_ay*508+star_list[i].x+cur_frame/20)%508,star_list[i].y,15)
	end
	printh("END_DRAW_STARS")
end

function draw_temple_background()
	printh("BEGIN_DRAW_TEMPLE_BACKGROUND")
	rectfill(0,0,127,64,14)
	draw_stars()

	
	rectfill(0,64,127,127,5)
	
	for i=0,2 do
		rectfill(0,66+i*2,127,66+i*2,6)
		rectfill(0,60-i*2,127,60-i*2,15)
	end
	printh("END_DRAW_TEMPLE_BACKGROUND")
end

function draw_fox_background()
	cls(9)
	
	srand(2)
	for i=1,8 do
		circfill((rnd(167)+cur_frame)%167-20,rnd(167),rnd(20),10)
	end

end

scene_index=1
scene_list={{load_fox_dynamic,update_fox_dynamic,draw_fox_background},
			{load_temple,update_temple,draw_temple_background},
			{load_factory,update_factory,draw_factory_background}}

function _init()
	cur_frame=0

	
	--~ init_3d() --need to call init_3d() to set up player, camera and lights
	load_scene(load_temple,update_temple,draw_temple_background)

end

function intersect_bounding_box(object_a, object_b)

	printh ("BEGIN_INTERSECT_BOUNDING_BOX")
	local test = 0

	if ((object_a.min_x+object_a.x < object_b.max_x+object_b.x) and (object_a.max_x+object_a.x > object_b.min_x+object_b.x) and
			 (object_a.min_y+object_a.y < object_b.max_y+object_b.y) and (object_a.max_y+object_a.y > object_b.min_y+object_b.y) and
			 (object_a.min_z+object_a.z < object_b.max_z+object_b.z) and (object_a.max_z+object_a.z > object_b.min_z+object_b.z)) then
		test = 1
	end

	
	printh ("ibb: " .. (test))
	
	printh ("END_INTERSECT_BOUNDING_BOX")

	return 
        ((object_a.min_x+object_a.x < object_b.max_x+object_b.x) and (object_a.max_x+object_a.x > object_b.min_x+object_b.x) and
         (object_a.min_y+object_a.y < object_b.max_y+object_b.y) and (object_a.max_y+object_a.y > object_b.min_y+object_b.y) and
         (object_a.min_z+object_a.z < object_b.max_z+object_b.z) and (object_a.max_z+object_a.z > object_b.min_z+object_b.z))
end

function update_player()
	
	printh ("BEGIN_UPDATE_PLAYER")
	old_x=player.x
	old_y=player.y
	old_z=player.z

	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	
	player.x+=player.vx
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	for object in all(obstacle_list) do
		if( intersect_bounding_box(player, object)) player.vx=0 player.x=old_x 
	end
	
	
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	player.y+=player.vy
	
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	
	
	player.z+=player.vz
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	for object in all(obstacle_list) do
		if( intersect_bounding_box(player, object)) player.vz=0 player.z=old_z 
	end
	
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	
	player.vx*=k_friction
	player.vy*=k_friction
	player.vz*=k_friction
	
	--~ printh ("player.x: " .. player.x)
	--~ printh ("player.y: " .. player.y)
	--~ printh ("player.z: " .. player.z)
	printh ("END_UPDATE_PLAYER")
end

function update_camera()	
	printh ("BEGIN_UPDATE_CAMERA")
	cam_x=player.x
	cam_y=player.y
	cam_z=player.z

	cam_ax=player.ax
	cam_ay=player.ay
	cam_az=player.az

	generate_cam_matrix_transform(cam_ax,cam_ay,cam_az)
	printh ("END_UPDATE_CAMERA")
end


function	matrix_inverse()
	printh ("BEGIN_MATRIX_INVERSE")
	local det = mat00* (mat11 * mat22- mat21 * mat12) -
                mat01* (mat10 * mat22- mat12 * mat20) +
                mat02* (mat10 * mat21- mat11 * mat20)
	local invdet=2/det
		

		
		mat00,mat01,mat02,mat10,mat11,mat12,mat20,mat21,mat22=(mat11 * mat22 - mat21 * mat12) * invdet,(mat02 * mat21 - mat01 * mat22) * invdet,(mat01 * mat12 - mat02 * mat11) * invdet,(mat12 * mat20 - mat10 * mat22) * invdet,(mat00 * mat22 - mat02 * mat20) * invdet,(mat10 * mat02 - mat00 * mat12) * invdet,(mat10 * mat21 - mat20 * mat11) * invdet,(mat20 * mat01 - mat00 * mat21) * invdet,(mat00 * mat11 - mat10 * mat01) * invdet

	--~ printh ("det: " .. (det))
	--~ printh ("invdet: " .. (invdet))
	--~ printh ("mat00: " .. ( mat00))
	--~ printh ("mat01: " .. ( mat01))
	--~ printh ("mat02: " .. ( mat02))
	--~ printh ("mat10: " .. ( mat10))
	--~ printh ("mat11: " .. ( mat11))
	--~ printh ("mat12: " .. ( mat12))
	--~ printh ("mat20: " .. ( mat20))
	--~ printh ("mat21: " .. ( mat21))
	--~ printh ("mat22: " .. ( mat22))



		--uh yeah i looked this one up :-)
	printh ("END_MATRIX_INVERSE")
end

function handle_buttons()
	
	printh ("BEGIN_HANDLE_INPUT")
	if(btn(0))then
		player.ay+=-.01
	end
	
	if(btn(1))then
		player.ay+=.01
	end
	
	generate_matrix_transform(cam_ax,cam_ay,cam_az)
	matrix_inverse()
	vx,vy,vz=rotate_point(0,0,.2)
	
	if(btn(2))then
	
		player.vx=-vx
		player.vy=-vy
		player.vz=-vz
	

	end
	
	if(btn(3))then

		player.vx=vx
		player.vy=vy
		player.vz=vz
	end
	
	printh ("END_HANDLE_INPUT")
end

function _update()
	
	printh ("BEGIN_UPDATE")
	if(btnp(4))then
		scene_index+=1
		if(scene_index>#scene_list)scene_index=1
		load_scene(scene_list[scene_index][1],scene_list[scene_index][2],scene_list[scene_index][3])
	end

	local t=stat(1)
	handle_buttons() -- handle default buttons for player-- this can be overwritten obviously.
	update_player() -- update the player with default movement, stopping at obstacles
	
	
	update_camera() -- update the camera based on player location and direction
	utility_time=stat(1)-t
	scene_update_func()

	printh ("END_UPDATE")
end

function rotate_cam_point(x,y,z)
	
	printh ("BEGIN_ROTATE_CAMP")
	--~ printh ("cam_mat00: " .. ( cam_mat00))
	--~ printh ("cam_mat10: " .. ( cam_mat10))
	--~ printh ("cam_mat20: " .. ( cam_mat20))
	--~ printh ("cam_mat01: " .. ( cam_mat01))
	--~ printh ("cam_mat11: " .. ( cam_mat11))
	--~ printh ("cam_mat21: " .. ( cam_mat21))
	--~ printh ("cam_mat02: " .. ( cam_mat02))
	--~ printh ("cam_mat12: " .. ( cam_mat12))
	--~ printh ("cam_mat22: " .. ( cam_mat22))
	
	--~ printh ("x: " .. (x))
	--~ printh ("y: " .. (y))
	--~ printh ("z: " .. (z))
	
	--~ printh ("tx: " .. (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20)
	--~ printh ("ty: " .. (x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21)
	--~ printh ("tz: " .. (x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22)
	printh ("END_ROTATE_CAMP")
	
	return (x)*cam_mat00+(y)*cam_mat10+(z)*cam_mat20,(x)*cam_mat01+(y)*cam_mat11+(z)*cam_mat21,(x)*cam_mat02+(y)*cam_mat12+(z)*cam_mat22
end


function project_point(x,y,z)
	printh ("BEGIN_PROJECT_POINT")
	--~ printh ("x: " .. (x))
	--~ printh ("y: " .. (y))
	--~ printh ("z: " .. (z))
	
	--~ printh ("sx: " .. (x*k_screen_scale/z+k_x_center))
	--~ printh ("sy: " .. (y*k_screen_scale/z+k_x_center))
	
	--~ printh ("k_screen_scale: " .. (k_screen_scale))
	--~ printh ("k_x_center: " .. (k_x_center))
	printh ("END_PROJECT_POINT")
	
	return x*k_screen_scale/z+k_x_center,y*k_screen_scale/z+k_x_center
end


function project_radius(r,z)
	printh ("BEGIN_PR")
	--~ printh ("sradius: " .. (r*k_screen_scale/abs(z)))
	--~ printh ("r: " .. (r))
	--~ printh ("z: " .. (abs(z)))
	--~ printh ("kss: " .. (k_screen_scale))
	printh ("END_PR")
	return r*k_screen_scale/abs(z)
end

function is_visible(object)

	printh ("BEGIN_IS_VIS")
	--~ printh ("object.tz: " .. (object.tz))
	--~ printh ("object.radius: " .. (object.radius))
	--~ printh ("z_max: " .. (z_max))
	--~ printh ("object.tz: " .. (object.tz))
	--~ printh ("object.radius: " .. (object.radius))
	--~ printh ("z_clip: " .. (z_clip))
	
	--~ printh ("object.sx: " .. (object.sx))
	--~ printh ("object.sradius: " .. (object.sradius))
	
	--~ printh ("object.sy: " .. (object.sy))
	--~ printh ("object.sradius: " .. (object.sradius))
	printh ("END_IS_VIS")
	
	
	if(object.tz+object.radius>z_max and object.tz-object.radius<z_clip and
	   object.sx+object.sradius>0 and object.sx-object.sradius<128 and
	   object.sy+object.sradius>0 and object.sy-object.sradius<128 )
	   then return true else return false end
end

function update_visible(object)
		object.visible=false

		local px,py,pz = object.x-cam_x,object.y-cam_y,object.z-cam_z
		
		printh ("BEGIN_UPDATE_VIS")
		--~ printh ("px: " .. px)
		--~ printh ("py: " .. py)
		--~ printh ("pz: " .. pz)
		--~ printh ("object.x: " .. object.x)
		--~ printh ("object.y: " .. object.y)
		--~ printh ("object.z: " .. object.z)
		--~ printh ("cam_x: " .. cam_x)
		--~ printh ("cam_y: " .. cam_y)
		--~ printh ("cam_z: " .. cam_z)
		
		object.tx, object.ty, object.tz =rotate_cam_point(px,py,pz)
		
		object.sx,object.sy = project_point(object.tx,object.ty,object.tz)
		object.sradius=project_radius(object.radius,object.tz)
		object.visible= is_visible(object)
		
		
		printh ("END_UPDATE_VIS")
end

function cam_transform_object(object)
	printh ("BEGIN_CAM_TRANSFORM")
	if(object.visible)then

		for i=1, #object.vertices do
			local vertex=object.t_vertices[i]

			vertex[1]+=object.x - cam_x
			vertex[2]+=object.y - cam_y
			vertex[3]+=object.z - cam_z
			
			--~ printh ("vertex[0]: " .. (vertex[1]))
			--~ printh ("vertex[1]: " .. (vertex[2]))
			--~ printh ("vertex[2]: " .. (vertex[3]))
			
			vertex[1],vertex[2],vertex[3]=rotate_cam_point(vertex[1],vertex[2],vertex[3])
			
			--~ printh ("vertex[0]: " .. (vertex[1]))
			--~ printh ("vertex[1]: " .. (vertex[2]))
			--~ printh ("vertex[2]: " .. (vertex[3]))
		
		end
	

	end
	printh ("END_CAM_TRANSFORM")
end



function update_light()
	printh ("BEGIN_UPDATE_LIGHT")
	printh ("END_UPDATE_LIGHT")
	t_light_x,t_light_y,t_light_z = rotate_cam_point(light1_x,light1_y,light1_z)
end

function update_3d()
	printh ("BEGIN_UPDATE_3D")
	for object in all(object_list) do
			update_visible(object)
			transform_object(object)
			cam_transform_object(object)
			update_light()
	end
	printh ("END_UPDATE_3D")
end

function quicksort(t, start, endi)
   start, endi = start or 1, endi or #t
  --partition w.r.t. first element
  if(endi - start < 1) then return t end
  local pivot = start
  for i = start + 1, endi do
    if t[i].tz <= t[pivot].tz then
      if i == pivot + 1 then
        t[pivot],t[pivot+1] = t[pivot+1],t[pivot]
      else
        t[pivot],t[pivot+1],t[i] = t[i],t[pivot],t[pivot+1]
      end
      pivot = pivot + 1
    end
  end
   t = quicksort(t, start, pivot - 1)
  return quicksort(t, pivot + 1, endi)
end

function three_point_sort(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
	printh("BEGIN_TPS")
	if(p1z>p2z) p1z,p2z = p2z,p1z p1x,p2x = p2x,p1x p1y,p2y = p2y,p1y
	if(p1z>p3z) p1z,p3z = p3z,p1z p1x,p3x = p3x,p1x p1y,p3y = p3y,p1y
	if(p2z>p3z) p2z,p3z = p3z,p2z p2x,p3x = p3x,p2x p2y,p3y = p3y,p2y
	
	--~ printh("p1x: " .. p1x);
	--~ printh("p1y: " .. p1y);
	--~ printh("p1z: " .. p1z);
	--~ printh("p2x: " .. p2x);
	--~ printh("p2y: " .. p2y);
	--~ printh("p2z: " .. p2z);
	--~ printh("p3x: " .. p3x);
	--~ printh("p3y: " .. p3y);
	--~ printh("p3z: " .. p3z);
	
	printf("END_TPS")
	return p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z
end

function z_clip_line(p1x,p1y,p1z,p2x,p2y,p2z,clip)
	printh("BEGIN_ZCL")
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
	printh("END_ZCL")
end

function render_object(object)
	printh("BEGIN_RENDER_OBJECT")

	--project all points in object to screen space
	--it's faster to go through the array linearly than to use a for all()
	for i=1, #object.t_vertices do
		local vertex=object.t_vertices[i]
		vertex[4],vertex[5] = vertex[1]*k_screen_scale/vertex[3]+k_x_center,vertex[2]*k_screen_scale/vertex[3]+k_x_center
		--~ printh ("vertex[3]: " .. vertex[4])
		--~ printh ("vertex[4]: " .. vertex[5])
		
	end

	for i=1,#object.faces do
	--for face in all(object.faces) do
		local face=object.faces[i]
	
		local p1=object.t_vertices[face[1]]
		local p2=object.t_vertices[face[2]]
		local p3=object.t_vertices[face[3]]
		
		local p1x,p1y,p1z=p1[1],p1[2],p1[3]
		local p2x,p2y,p2z=p2[1],p2[2],p2[3]
		local p3x,p3y,p3z=p3[1],p3[2],p3[3]

		
		local cz=.01*(p1z+p2z+p3z)/3
		local cx=.01*(p1x+p2x+p3x)/3
		local cy=.01*(p1y+p2y+p3y)/3
		local z_paint= -cx*cx-cy*cy-cz*cz
		
		--~ printh("p1x: " .. p1x)
		--~ printh("p1y: " .. p1y)
		--~ printh("p1z: " .. p1z)
		--~ printh("p2x: " .. p2x)
		--~ printh("p2y: " .. p2y)
		--~ printh("p2z: " .. p2z)
		--~ printh("p3x: " .. p3x)
		--~ printh("p3y: " .. p3y)
		--~ printh("p3z: " .. p3z)
		--~ printh("cx: " .. cx)
		--~ printh("cy: " .. cy)
		--~ printh("cz: " .. cz)
		--~ printh("z_paint: " .. z_paint)
		
		
		if(object.background==true) z_paint-=1000 
		face[6]=z_paint
		

		if((p1z>z_max or p2z>z_max or p3z>z_max))then
			if(p1z< z_clip and p2z< z_clip and p3z< z_clip)then
			--simple option -- no clipping required

					local s1x,s1y = p1[4],p1[5]
					local s2x,s2y = p2[4],p2[5]
					local s3x,s3y = p3[4],p3[5]
					--~ printh("s1x: " .. s1x)
					--~ printh("s1y: " .. s1y)
					--~ printh("s2x: " .. s2x)
					--~ printh("s2y: " .. s2y)
					--~ printh("s3x: " .. s3x)
					--~ printh("s3y: " .. s3y)
		

					if( max(s3x,max(s1x,s2x))>0 and min(s3x,min(s1x,s2x))<128)  then
						--only use backface culling on simple option without clipping
						--check if triangles are backwards by cross of two vectors
						--~ printh("k0")
						if(( (s1x-s2x)*(s3y-s2y)-(s1y-s2y)*(s3x-s2x)) < 0)then
							--~ printh("k1")
						
							if(object.color_mode==k_colorize_dynamic)then
								--~ printh("k2")
								--nx,ny,nz = vector_cross_3d(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
								--save a bit on dynamic rendering by moving this funciton inline
								p2x-=p1x 
								p2y-=p1y 
								p2z-=p1z	
								p3x-=p1x 
								p3y-=p1y 
								p3z-=p1z
							
								--~ printh("p2x: " .. p2x)
								--~ printh("p2y: " .. p2y)
								--~ printh("p2z: " .. p2z)
								--~ printh("p3x: " .. p3x)
								--~ printh("p3y: " .. p3y)
								--~ printh("p3z: " .. p3z)
									
								local nx = p2y*p3z-p2z*p3y
								local ny = p2z*p3x-p2x*p3z
								local nz = p2x*p3y-p2y*p3x
								
								--nx,ny,nz = normalize(nx,ny,nz)
								--save a bit by moving this function inline
								nx=shl(nx,2) ny=shl(ny,2) nz=shl(nz,2)
								
								--~ printh("nx: " .. nx)
								--~ printh("ny: " .. ny)
								--~ printh("nz: " .. nz)
								
								local inv_dist=1/sqrt(nx*nx+ny*ny+nz*nz)
								nx*=inv_dist ny*=inv_dist nz*=inv_dist						
															
								
								--b = vector_dot_3d(nx,ny,nz,t_light_x,t_light_y,t_light_z)
								--save a bit by moving this function inline
								face[4],face[5]=color_shade(object.color, mid( nx*t_light_x+ny*t_light_y+nz*t_light_z,0,1)*(1-k_ambient)+k_ambient )
								
								--~ printh("face[3]: " .. face[4])
								--~ printh("face[4]: " .. face[5])
							end
								
						
							--new_triangle(s1x,s1y,s2x,s2y,s3x,s3y,z_paint,face[k_color1],face[k_color2])
							--faster to move new triangle function inline
							add(triangle_list,{p1x=s1x,
												p1y=s1y,
												p2x=s2x,
												p2y=s2y,
												p3x=s3x,
												p3y=s3y,
												tz=z_paint,
												c1=face[k_color1],
												c2=face[k_color2]})
							

						end
					end
					
			--not optimizing clipping functions for now
			--these still have errors for large triangles
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
	printh("END_RENDER_OBJECT")
end

function shade_trifill( x1,y1,x2,y2,x3,y3, tz, color1, color2)
	printh("BEGIN_SHADE_TRIFILL")

		  local x1=band(x1,0xffff)
		  local x2=band(x2,0xffff)
		  local y1=band(y1,0xffff)
		  local y2=band(y2,0xffff)
		  local x3=band(x3,0xffff)
		  local y3=band(y3,0xffff)
		  
			printh("x1: " .. x1)
			printh("x2: " .. x2)
			printh("x3: " .. x3)
			printh("y1: " .. y1)
			printh("y2: " .. y2)
			printh("y3: " .. y3)
	
		  local nsx,nex
		  --sort y1,y2,y3
		  if(y1>y2)then
			y1,y2=y2,y1
			x1,x2=x2,x1
		  end
		  
		  if(y1>y3)then
			y1,y3=y3,y1
			x1,x3=x3,x1
		  end
		  
		  if(y2>y3)then
			y2,y3=y3,y2
			x2,x3=x3,x2		  
		  end
		  
			printh("x1: " .. x1)
			printh("x2: " .. x2)
			printh("x3: " .. x3)
			printh("y1: " .. y1)
			printh("y2: " .. y2)
			printh("y3: " .. y3)
		  
		 if(y1!=y2)then 	
			--~ printh("y1 != y2")	 
			local delta_sx=(x3-x1)/(y3-y1)
			local delta_ex=(x2-x1)/(y2-y1)
			
			printh("delta_sx: " .. delta_sx)
			printh("delta_ex: " .. delta_ex)
			
			if(y1>0)then
			--~ printh("y1 > 0")	 
				nsx=x1
				nex=x1
				min_y=y1
			else --top edge clip
			--~ printh("y1 > 0 -- else")	 
				nsx=x1-delta_sx*y1
				nex=x1-delta_ex*y1
				min_y=0
			end
			
			max_y=min(y2,128)
			printh("min_y: " .. min_y)
			printh("max_y: " .. max_y)
			printh("nsx:   " .. nsx)
			printh("nex:   " .. nsx)
			
			for y=min_y,max_y-1 do
			--~ printh("i: " .. y)	

			--rectfill(nsx,y,nex,y,color1)
			if(band(y,1)==0)then
				--~ printh("(i & 1): " .. (band(y,1)))	
				--~ printh("color1: " .. color1)	
				rectfill(nsx,y,nex,y,color1) 
			else 
				--~ printh("else (i & 1): " .. (band(y,1)))	
				--~ printh("color2: " .. color2)
				rectfill(nsx,y,nex,y,color2) 
			end
			nsx+=delta_sx
			nex+=delta_ex
			end

		else --where top edge is horizontal
			nsx=x1
			nex=x2
		end

		  
		if(y3!=y2)then
			printh("(y3 != y2)")
			local delta_sx=(x3-x1)/(y3-y1)
			local delta_ex=(x3-x2)/(y3-y2)
			
			printh("delta_sx: " .. delta_sx)
			printh("delta_ex: " .. delta_ex)
			
			min_y=y2
			max_y=min(y3,128)
			printh("min_y: " .. min_y)
			printh("max_y: " .. max_y)
			printh("nsx:   " .. nsx)
			printh("nex:   " .. nsx)
			
			if(y2<0)then
				printh("y2 < 0")
				nex=x2-delta_ex*y2
				nsx=x1-delta_sx*y1
				min_y=0
			end
			
			 for y=min_y,max_y do

				--rectfill(nsx,y,nex,y,color1)
				if(band(y,1)==0)then 
					printh("(i & 1)")
					rectfill(nsx,y,nex,y,color1) 
				else 
					printh("else (i & 1)")
					rectfill(nsx,y,nex,y,color2) 
				end
				nex+=delta_ex
				nsx+=delta_sx
			 end
			
		else --where bottom edge is horizontal
			printh("else (y3 != y2)")
			--rectfill(nsx,y3,nex,y3,color1)
			if(band(y,1)==0)then 
					printh("(i & 1)")
				rectfill(nsx,y3,nex,y3,color1) 
			else 
					printh("else (i & 1)")
				rectfill(nsx,y3,nex,y3,color2) 
			end
		end

	printh("END_SHADE_TRIFILL")
end

function draw_triangle_list()
	printh("BEGIN_DRAW_TRIANGLE_LIST")
	--for t in all(triangle_list) do
	for i=1,#triangle_list do
		local t=triangle_list[i]
		shade_trifill( t.p1x,t.p1y,t.p2x,t.p2y,t.p3x,t.p3y, t.tz, t.c1,t.c2 )
	end
	printh("END_DRAW_TRIANGLE_LIST")
end

function draw_3d()
	printh("BEGIN_DRAW_3D")
	triangle_list={}
	quicksort(object_list)
	
	start_timer()
	for object in all(object_list) do
		if(object.visible and not object.background) then
			render_object(object) --sort_faces(object)
			--if(object.color_mode==k_colorize_dynamic or object.color_mode==k_multi_color_dynamic) color_faces(object,object.color)
		end
	end
	render_time=stop_timer()
	
	start_timer()
		quicksort(triangle_list)
	sort_time=stop_timer()
	
	start_timer()
		draw_triangle_list()
	triangle_time=stop_timer()
	printh("END_DRAW_3D")
end


function _draw()
	printh("BEGIN_DRAW")

	local t=stat(1)
	cur_frame+=1
	
	scene_background_function()
	

	local t=stat(1)
	update_3d() -- call update_3d() at the end of the _update() function to transform etc.
	update_time=stat(1)-t
	draw_3d() --render objects into triangles, sort the triangles and draw them onto the screen
	draw_time=stat(1)-t

	
	--print("utility time: "..utility_time,0,7,8)
	--print("update time: "..update_time,0,14,8)
	--print("draw time: "..draw_time,0,21,8)
	--print("render time: "..render_time,32,28,12)
	--print("sort time: "..sort_time,32,35,12)
	--print("triangle time: "..triangle_time,32,42,12)
	print(stat(1),2,0,7)
	
	print("z for next scene",2,120,7)
	
	printh("END_DRAW")
	while true do
	end

end



__gfx__
00000000000000000000000000000000000000000000000000000000000000005555555555555555555555550000000000000000000000000000000000000000
01100000055555550666666607777777000c100000000000000cc000000000005666666556666665566666650111111101111111011111110222222202222222
01000000050000050600000607000007000c10000000000000cccc00000000005600006556000065560200650100000101000001010000010200000202000002
00000000050555050605550607000507000c100000666600000cc000000000005622206556020265562000650101110101011101010001010202220202022202
00000000050050050605550607005007000c10000666666000044000005555005602006556202025560200650100100101011101010010010200200202022202
00000000050050050605050607000507000c10000600006000044000056666505602006556200025562000650100100101010101010001010200200202020202
00000000050000050600000607005007000c10000066660000044000056006505666666556666665566666650100000101000001010010010200000202000002
00000000055555550666666607777777000c10000000000000044000056006505555555555555555555555550111111101111111011111110222222202222222
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02222222060060600000000000000000000000000000000001111010010111111010000111000000000000000000000000000000000000000000000000000000
02000002000000000000000000000000000000000000000017777171171717777171001777100000000000000000000000000000000000000000000000000000
02000202600000660000000000000000000000000000000017111171171717111171001711710000000000000000000000000000000000000000000000000000
02002002660000060000000000000000000000000000000017777177771717771171001711710000000000000000000000000000000000000000000000000000
02000202000000000000000000000000000000000000000001117171171717111171111711710000000000000000000000000000000000000000000000000000
02002002060600600000000000000000000000000000000017777171171717777177771777100000000000000000000000000000000000000000000000000000
02222222000660000000000000000000000000000000000001111010010111111011110111000000000000000000000000000000000000000000000000000000
00a0000000000a000000a00000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaaaa00aaaaaa0000aaa0000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a0000000000a000000a00000055550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0ee00ee00ee00ee00000a00005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0ee88ee00ee88ee00ee00ee000055550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008000000800000ee88ee000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008000000800000008000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888888888880000000000000000000000000000000000000000000008888888888888888888000000000000000000000000000000000000000000
00000000088aaaaaaaaaa888000000000000000000000000000000000000000000008aaaaaaaaaaaaaaa88000000000000000000000000000000000000000000
0000000000888aaaaaaaaaa880000000000000000000000000000000000000000000888aaaaaaaaaaa8800000000000000000000000000000000000000000000
0000000000088aaaaaaaaaaa88888888888800888888888000000888888888880000088aaaaaaaaaa88888888888888888888888800088888888888000000000
0000000000088aaaaaaaaaaaa8888aaaaa88088aaaaaaa88800088aaaaaaaaa8800088aaaaaaaaaaa88aaaaaaaaaa88888aaaaa880088aaaaaaaa88000000000
00000000000889999888999998888999998888999999999988088999999999998800889999999999889999999999999888999998808899999999880000000000
000000000088aaaaa88888aaaa88aaaaa8888aaaaaaaaaaaa888aaaaaaaaaaaaa8888aaaaaa8888888aaaaaaaaaaaaa888aaaaa8888aaaaaaaa8800000000000
00000000008899998888889999889999988889999999999998889999999999999888899999988888899999988899999888899999889999999988000000000000
000000000088aaaa888888aaa88aaaaa8888aaaaaa888aaaa88aaaaaa888aaaaa8888aaaaa8888888aaaaa8888aaaa88888aaaaa8aaaaaaaa880000000000000
00000000088999998888899998899999888899999888899988899999888899998888999999988888899998888899998888899999999999998800000000000000
00000000088aaaa88888aaaaa88aaaaa8888aaaa8888aaa8888aaaa88888aaaa8888aaaaaaaaaaa8aaaaa8888aaaa8888888aaaaaaaaaaa88000000000000000
00000000088999988899999988999998888999998888998888999998888999988889999999999988999998888999988888889999999999880000000000000000
00000000889999999999999888999998888999998888888888999998888999988889999999999989999988889999988888889999999998800000000000000000
00000000889999999999988889999988889999988888888889999988889999988889999999999889999988889999888888888999999988000000000000000000
00000000889999999988888889999988889999988888888889999988889999888889999988888899999888899999888888889999999880000000000000000000
00000008899999988880000889999988899999888888888899999888899999888899999988888899999888899998888888899999999880000000000000000000
00000008899999880000008899999888899999888888888899999888899998888999999888888899999888899998888888999999999880000000000000000000
00000088999999880000008899999888899999888888888899999888899998888999999888888999999888999988888889999999999880000000000000000000
00000088999998800000088999998888999999888999988999999888999988888999998888888999999888999988888899999999999880000000000000000000
00000888999998800000088999998888999999888999988999999888999988899999998888888999999999999988888999999999999988000000000000000000
00000889999988000000088999998888999999999999988999999999999988899999988888888999999999999888889999999889999988000000000000000000
00000889999988000000889999988088999999999999888999999999999988999999988888888899999999999888899999998889999998800000000000000000
00008899999998800000889999988008899999999999888899999999999999999999988888888888999999988888999999988088999998800000000000000000
00008888888888800000888888888008888999999988880888999999999999999998888888888888888888888889999999880088999998800000000000000000
00000000000000000000000000000000088888888888000008888888888888888888888888888888888888888899999998800088999998800000000000000000
00000000000000000000000000000000000888888800000000000888888999999999999998888888888888889999999988000008899999880000000000000000
00000000000000000000000000000000000000000000000000008888999999999999999999999998888888999999999880000008899999880000000000000000
00000000000000000000000000000000000000000000000000888899999999999999999999999999999999999999998800000008899999988000000000000000
00000000000000000000000000000000000000000000000008889999999999999999999999999999999999999999888000000000888888888000000000000000
00000000000000000000000000000000000000000000000088899999999999999999999999999999999999999998800000000000000000000000000000000000
00000000000000000000000000000000000000000000000888999999999999999999999999999999999999999888000000000000000000000000000000000000
00000000000000000000000000000000000000000000008889999999888888899999999999999999999999988800000000000000000000000000000000000000
00000000000000000000000000000000000000000000008888888888800000888888899999999999998888880000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000888000000000000000000888888888888888000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000088899999999999999
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000888999999988888889
eeeeeeeeeee55555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555eeeeeeeeeeeeeeeee00020000000000000000000000000000000000888888888880000088
eeeeeeeeeee5555455eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555455eeeeeeeeeeeeeeee000f00000001000000050000000e2000000000088800000000000000
eeeeeeeeee5551155445eeeeeeeeeeeeeeeeeeeeeeeeeeee555445555eeeeeeeeeeeeeee02fff200000000000057500000022000000000000000000000000000
eeeeeeeeee4411111154445eeeeeeeeeeeeeeeeeeeeeee55544555545eeeeeeeeeeeeeee000f0000000000000005000000000000000000000000000000000000
eeeeeeeeee55511115554444eeeeeeeeeeeeeeeeeeee5554445115445eeeeeeeeeeeeeee00020000000000000000000000000000000000000000000000000000
eeeeeeeee4411111111154444eeeeeeeeeeeeeeeeee554444511544f5eeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee45551111115554445eeeeeeeeeeeeeeee554444511544fffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee441111111111154445eeeeeeeeeeeeee55444451115444ffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee4555111111115554445eeddddddddeed554444111544ffffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee44111111111111154445d666666666d55444451115444fffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee4555111115551115444567777777776554444111554fffffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee4411111544455555445d666667777654444511554444fffeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee4555115444444555445d666666666d54444555444fffffeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee44111154fff444554455dd6666666554445554ff444fffeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee45551154fff4444544455dddddd6d55444554444444fffeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeee451115444444444444155555555554444444fffff4fffeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeee455511444444444ff411555555511444444444f444ffeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee451115444444999f415ddddddd5544fff44444444ffeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee45511544449944994155555555554ffffff44444fffeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee411154444444444455555555554fffffffffff44ffeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee4515444444444444444449999ffffffffffffff4455eeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee455544442222224444444499fffff777777ffffff51eeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee454444444422444444449999999ffffffffffffff651eeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee44442222222222224444449fffff777777777fffffd5eeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeee44444442222222444444499999fffffffffffffff765eeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee444422222222222222244449ffff99f77777fff77776deeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee4444444221111112224444999999944444dffffffff7d1eeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee44422222115555111222444999994444d6ddffff777765eeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee444442211144444511244444499444ff77fddffffff76deeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeee44422211154999995552244449444f99999644fff7776deeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeee154442221115555555551244444444555555555fffff76deeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee115422211111577b73b5511544444445b73b77544fff7776eeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee1154444222111577b33b5551555444455b33b77444ffff77ddeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee11544422111115777bb775515444554d77bb777499ffff77dd6eeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee115444442222111557777d111499455dfd7777449ffffff776ddeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee1144444222111111155d55112499f4444444999999ffff7776dd6eeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee1155554422222111112222224999ff444444449fffffff77655d6eeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee111511422221111111111122249ff7f44449999ffffff776d55ddeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee1111244442222211112222244999f77f4444449fff77776ddddddeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee1112d222222211111112222249ffff7ff444999d6f776dd66d6deeeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee1112dd222222221112222244999f77777ff444515d665d66d6665eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee1115dd2222222112222222449ffff7777ff4515555515ddd66d1eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee11115dd2222221122222444999f777777ff411dd1115d55666d1eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee111115dd21221112222222249ffff7777f44511115dd515d66d1eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee1111115d2111111122222499996777777f44511115d5111566d1eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee11111111111111112222222111177777ff54d515555d51115d51eeeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeee1111111111111151122222111dd1677ff44d515d55d6651111111eeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeee111111111111111111124421111d167ff44551166d5d676d555511eeeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeee1111111111111111111122441111116ff451111567d5d6776ddd6d11eeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeee551111111111111111111124451111fff4511115df7d5d67776dd66d1eeeeeeee00000000000000000000000000000000000000000000000000000000
eeeeeedd51111111111111111111115545224444511154ff76d5d67777d5d6651eeeeeee00000000000000000000000000000000000000000000000000000000
eeeee5d6511155555111111111111115555544451114499af655d6677765d6651eeeeeee00000000000000000000000000000000000000000000000000000000
eeee5d6d115ddddd555111111111111155444551154252222d5dd667777d5d665eeeeeee00000000000000000000000000000000000000000000000000000000
eeeed66515d6dddddd551111111111111155111544999444655ddd6677765d665eeeeeee00000000000000000000000000000000000000000000000000000000
eeeed6655d6666ddddd51111111111111111124488882222655d66666776dd665eeeeeee00000000000000000000000000000000000000000000000000000000
eee566d5d666dd5ddddd51114111444452224449999444f6555dddd66666d566d1eeeeee00000000000000000000000000000000000000000000000000000000
eeed6d5d666d51115ddd51111411144444444488882222d555d5dd5555d6d5d765eeeeee00000000000000000000000000000000000000000000000000000000
eeeddd5d6651111111dd11111141114444444999444445115dd5111111555d6765eeeeee00000000000000000000000000000000000000000000000000000000
ee5ddd55d5111111115511111114414488888888445111115d51111115ddd66765eeeeee00000000000000000000000000000000000000000000000000000000
eedddd51111111155d511111111444424999991111111111551111111ddd667765eeeeee00000000000000000000000000000000000000000000000000000000
ee6dddd5511115dd66d5111111114444444422511111111155155dd55dd667777deeeeee00000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
__label__
99777999997779777977797779999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99797999997979997999797999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99797999997779977999797779999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99797999999979997999799979999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99777997999979777999797779999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999aaaaaaa999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaa9999999999999999
9999999999999999aaaaaaa99999999999999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaa999999999999999
99999999999999aaaaaaaaaaa99999999999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaa99999999999999
999999999999aaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaa9999999999999
99999999999aaaaaaaaaaaaaaaaa999999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaa999999999999
9999999999aaaaaaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaa999999999999
999999999aaaaaaaaaaaaaaaaaaaaa999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
999999999aaaaaaaaaaaaaaaaaaaaa999999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
99999999aaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
99999999aaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaa99999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999e999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaa999999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa999999999999999999999999999eeee8999999999999999999999999999999999aaaaaaaaaaaaaaaaaaa999999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999eeeee29999999999999999999999999999999999aaaaaaaaaaaaaaaaa9999999999999
9999999aaaaaaaaaaaaaaaaaaaaaaaaa999999999999999e9999999999ee888299999999999999999999999999999999999aaaaaaaaaaaaaaa99999999999999
99999999aaaaaaaaaaaaaaaaaaaaaaa999999999999999eee999aaa99eeeee22999999999999999999999999999999999999aaaaaaaaaaaaa999999999999999
99999999aaaaaaaaaaaaaaaaaaaaaaa99999999999999988eeaaaaaaae8888229999999999999999999999999999999999999aaaaaaaaaaa9999999999999999
999999999aaaaaaaaaaaaaaaaaaaaa9999999999999999eeeeeaaaaeeeeee222e99999999999999999999999999999999999999aaaaaaa999999999999999999
999999999aaaaaaaaaaaaaaaaaaaaa9999999999999999888eeeaeeeeeee822ee999999999999999999999999999999999999999999999999999999999999999
9999999999aaaaaaaaaaaaaaaaaaa99999999999999999288eefffeeeeeee2eee999999999999999999999999999999999999999999999999999999999999999
99999999999aaaaaaaaaaaaaaaaa99999999999999999928eeeeeeeee88888eee999999999999999999999999999999999999999999999999999999999999999
999999999999aaaaaaaaaaaaaaa999999999999999999fffffff8eeeeeeeeeeee999999999999999999999999999999999999999999999999999999999999999
99999999999999aaaaaaaaaaa99999999999999999998eeeee8822888eee8ee22999999999999999999999999999999999999999999999999999999999999999
9999999999999999aaaaaaa9999999999999999999998fff88888888888888222999999999999999999999999999999999999999999999999999999999999999
999999999999999999999999999999999999999999998ee888882222888882222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999ffffffffe888888882222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999928888888888882228882222999999999999999999999999999999999999999999999999999999999999999
9999999999999999999999999999999999999999928888eeeeeeeeeeee8882222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999222222228888888888822222999999999999999999999999999999999999999999999999999999999999999
9999999999999999999999999999999999999999922888888888eeeeee2222222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999222222222222222222222222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999222888888822222222222222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999992222222222222222222222999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999922222222222222222222299999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999922222222222222222222299999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999992222222222222222222e99999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999222222222222222288829999999999999999999999999999999999999999999999999999999999999
9999999999999999999999999999999999999999999999922222222222222eeeeee9999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999988822222228888888889999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999988888822eeeeeeeeeeee999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999988888888888888888888889999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999928888e888eeeeeeeeeeeeeee99999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999928888888888888888888eeeee8999999999999999999999999999999999999999999999999999999
999999999999999999999999999999999999999999999999288eee88888eeeeeeeefeeeeeeee9999999999999999999999999999999999999999999999999999
999999999999999999999999999999999999999999999999288888888888888888eeeeeeeeeeee99999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999928eeee8888888eeeefffffffffffff99999999999999999999999999999999999999999999999999
9999999999999999999999999999999999999999999999998888888888888888eeeeeeeeeeeeee89999999999999999999999999999999999999999999999999
999999999999999999999999999999999999999999999999888eee888888888eefffffffffffff88999999999999999999999999999999999999999999999999
999999999999999999999999999999999999999999999999888888888888888888eeeeeeeeeeee88899999999999999999999999999999999999999999999999
aa99999999999999999999999999999999999999999999999888ee888888888eeeeeffffffffff88889999999999999999999999999999999999999999999999
aaaa99999999999999999999999999999999999999999999998888888888888888888eeeeeeeeee8888999999999999999999999999999999999999999999999
aaaaaa99999999999999999999999999999999999999999999888e88888888eeeeeeeeeeeeeeeee8888899999999999999999999999999999999999999999999
aaaaaaa9999999999999999999999999999999999999999999988888888888888888888eeeeeee88888889999999999999999999999999999999999999999999
aaaaaaaa999999999999999999999999999999999999999999988828888888eeeeeeeeeeeeeeeeee888889999999999999999999999999999999999999999999
aaaaaaaaa9999999999999999999999999999999999999999998888288888888888888888eeeee88888889999999999999999999999999999999999999999999
aaaaaaaaaa9999999999999999999999999999999999999999988888288888eeeeeeeeeeeeeeeeeeee8889999999999999999999999999999999999999999999
aaaaaaaaaa9999999999999999999999999999999999999999928888828888e888888888888ee888888888999999999999999999999999999999999999999999
aaaaaaaaaaa999999999999999999999999999999999999999928888882888eeeeeeeeeeeeeeeeeeeee888999999999999999999999999999999999999999999
aaaaaaaaaaa9999999999999999999999999999999999999999288888822e822888888888888e888888888999999999999999999999999999999999999999999
aaaaaaaaaaaa9999999999999999999999999999999999999992888888888888888eeeeeeeeffeeeeeee88299999999999999999999999999999999999999999
aaaaaaaaaaaa99999999999999999999999999999999999999928888888822222288888888eeeee8888888299999999999999999999999999999999999999999
aaaaaaaaaaaaa9999999999999999999999999999999999999922888888e88888888888eefffffeeeeeee8229999999999999999999999999999999999999999
aaaaaaaaaaaaa9999999999999999999999999999999999999922288888882222228eeee8eeeeee8888888229999999999999999999999999999999999999999
aaaaaaaaaaaaa999999999999999999999999999999999999992228888eeee888eeffffffffffff8eeeeee222999999999999999999999999999999999999999
aaaaaaaaaaaaa999999999999999999999999999999999999999222888ee882eeeeeeeeeeeeeee88888882222999999999999999999999999999999999999999
aaaaaaaaaaaaa9999999999999999999999999999999999999998228eeeeeeeeeeeffffffffff888eeee22822999999999999999999999999999999999999999
aaaaaaaaaaaaa999999999999999999999999999999999999999222288eee8eeeeeeeeeeeeeee888888222222999999999999999999999999999999999999999
aaaaaaaaaaaaa9999999999999999999999999999999999999998888eeeeeeeeeeefffff888888888e2228822999999999999999999999999999999999999999
aaaaaaaaaaaaa99999999999999999999999999999999999999922228eeeeeeeeeee222222888888882222222999999999999999999999999999999999999999
aaaaaaaaaaaaa9999999999999999999999999999999999999ef8888eeeeeeee2228888888888888822288882999999999999999999999999999999999999999
aaaaaaaaaaaa9999999999999999999999999999999999999eee22828eeee2222222222288888888222222222999999999999999999999999999999999999999
aaaaaaaaaaaa9999999999999999999999999999999999999eee88888ffffffff222888888888882222888882999999999999999999999999999999999999999
aaaaaaaaaaa99999999999999999999999999999999999999eee22888eeeeeeeeeeee2888888882222222222e999999999999999999999999999999999999999
aaaaaaaaaaa99999999999999999999999999999999999999eefffffeeeffffffffffffffffff22222fffffff999999999999999999999999999999999999999
aaaaaaaaaa999999999999999999999999999999999999999eee8eee8eeeeeeeeeeeeeeeeeeeeee8eeeeeeeee999999999999999999999999999999999999999
aaaaaaaaaa99999999999999999999999999999999999999fffeefffeeeeefffffffffffffffffffffeeeeffff99999999999999999999999999999999999999
aaaaaaaaa999999999999999999999999999999999999999ee88eee288eeeeeeeeeeeeeeeeeeeeeeee88888eee99999999999999999999999999999999999999
aaaaaaaa9999999999999999999999999999999999999999feeeff222eeeeeeffffffffffffffffffeeeeeeeeee9999999999999999999999999999999999999
aaaaaaa999999999999999999999999999999999999999998888e222288eeeeeeeeeeeeeeeeeeeeeeeee88888829999999999999999999999999999999999999
aaaaaa9999999999999999999999999999999999999999999eeef9aaa8eeee888eeeffffffffffffeeeeeeeee889999999999999999999999999999999999999
aaaa9999999999999999aaaaa9999999999999999999999999999aaaa22ee88888eeeeeeeeeeeeeeeeeeee888229999999999999999999999999999999999999
aa9999999999999999aaaaaaaaa99999999999999999999999999aaaa28e88888888eeeeeeeeffffeeeeeeee8889999999999999999999999999999999999999
9999999999999999aaaaaaaaaaaaa99999999999999999999999aaaaaa22222228888eeeeeeeeeeeeeeeeee82299999999999999999999999999999999999999
999999999999999aaaaaaaaaaaaaaa999999999999999999999aaaaaaa822222222222ee22222228888888282999999999999999999999999999999999999999
999999999999999aaaaaaaaaaaaaaa999999999999999999999aaaaaaa2222222222222222222288888882299999999999999999999999999999999999999999
99999999999999aaaaaaaaaaaaaaaaa9999999999999999999aaaaaaaaa288888882222222222288888228999999999999999999999999999999999999999999
99999999999999aaaaaaaaaaaaaaaaa9999999999999999999aaaaaaaaaaaaa2222222222eeeee88882229999999999999999999999999999999999999999999
9999999999999aaaaaaaaaaaaaaaaaaa999999999999999999aaaaaaaaaaaaaaaaaaaa8822222228822899999999999999999999999999999999999999999999
9999999999999aaaaaaaaaaaaaaaaaaa99999999999999999aaaaaaaaaaaaaaaaaaaaaaaaa222222229999999999999999999999999999999999999999999999
9977799999777aa77a777aaaaa77aa7779797977799999977aa77a777a77aa777aaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
9999799999799a7a7a7a7aaaaa7a7a7a99797997999999799a7aaa7aaa7a7a7aaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
9997999999779a7a7a77aaaaaa7a7a7799979997999999777a7aaa77aa7a7a77aaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
997999999979997a7a7a7aaaaa7a7a7999797997999999997a7aaa7aaa7a7a7aaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
9977799999799977aa7a7aaaaa7a7a7779797997999999779aa77a777a7a7a777aaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
999999999999999aaaaaaaaaaaaaaa9999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999999999999999999999
999999999999999aaaaaaaaaaaaaaa99999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999
9999999999999999aaaaaaaaaaaaa999999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999999999999999999999

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0100000200000300000300300000000000000000000000000000000000000000000000002200000000000100000001000001000001000002000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000000000000
000c0000000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030b00000b0000000000000000000023000000000000000000000d010d010d010000000000000d01000000000000000000000000000000000009000000000000
000000000000000000000000000000000002000000020000000000000000000400000000000000000000000000000000000000000000000000000000000000000003030003030000000000000b0b000000020000000002000000000d000d000d000000000300000d0000000d01000d01000e000e000000000000000000000000
2300000000000000000700000000000000000000000000060000060000000000000002000000050000050000000000000000002000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000200000000000000000000000000d00000000000000000000000004040400
0000000007000000000000002100000000000007000000000000230000060000000000000000000000000000200000000000000000000000002100000010080000000000230000000000010000000000002000000100110000000000000000000020010000000000000000000000000000000000000000110000000000000000
200000000000000020000000000000000000000000000006000006000000000000000200000005000005000000000000000000000000000000000000001000000000000000000003000000000000000000020000000000000000010000000000000000000000000f000f000000000d0100000101000000000000000004040400
00000000000000000000000000000000000200000002000000000000000000040000000000000000000000000010080000000000000000000000010000000000000000000000000b0000000000000023000000000000020000000100000001000000000003000000000000000000000000000000000000000000000000000000
00000f00000f000000000000000000000000000000000000000000000000000000000000000000000101000000000000000100000100000200000100000000000000000000000000000000000b0b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000
010000020000030000030000000000000000000000000000000000002200000000000000000d0f0000000000000000000000000000000000000000080000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000000000000
0c00000000000000000000000000000b22000b2200000b00000000000000000000000000000f0d000000000000000021000000000000000000000000000000000000000000000000000006000000000000000400000000000000000400000000230000000000000000000000000000000e000000000000000000000000000000
0000000000000004000000040000000000000000000000000000000000000000000000000000000000000000060000000000000000000800000000210000080000000000000000000000000000000000000000000000040000000000000000000000000000000000230000000000000000000000000500000000000000000000
00000c00000000000004000000000000000000000000000000000010000f000e00000000000000000000000000000000000000000000000000000000000000000020080000110006000000000000000400000000000000000000000000002300000000000000000000000d00000000000e000000200000000000000000060000
0000000000000004000000040000000000000000000000000000000000002300000000000000000000000000000000000010000000002100000800000000000000000000000000000000000000000000000000040000000004000000000000000000000023000000000000000000000000002000000000000000000000060000
000000000c00000000040000000000000000000000000000110000000000000023000000000000000000000000000000100c000000000000000000000000080000000000000021000000060000042200000400000000000000000000000000000d0d00000000000700000000070000000e000000200000000000000000060000
0000000000000004000000000000000000000000000000000000000000000000000023000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0d000000000000000000000000000000000000000500000000000000000000
00000c00000000000004000000000000000000000000000000000010000f000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000d00000000000e000000000000000000000000000000
00000000000000040000000400000000000000000000000000000000000000000000000000000000000d0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000220000002200000000000000000000000000000000000000
0c0000000000000000000000000022000b22000b2200000b00000000000000000000000000000000000f0d000000000000000800000000000000000000040000000000000000000e0000000e0000000000000000000000000000000000000000000000000000000000000000000000000e0000000f0000000000000000040400
080000000000000000000000050005000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000002300000000000000000000000000000000000000000300000000000d000000080000000000000000000000000000000000000000000000050000000000000000
0000000000000000000000000000000000000000000000000000000000000010000000080000000000000000000b00000000000800000000000a0000000000000000000000000000000e0000000e000000000000000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000
0000000800080000000000000000000000040000000000000004001000000000000000000000001000000000000b0000000000000000000000000000000000000000000b210000000000000000000000000000000000200000000020000f000a00000000000007000000000000060000000f0000000000230005000007000000
000000000000000008000000000000000000000400000004000000000800000000000010000000000000000000000d000000000000000800000000000004000000000000000000000000000e0000000000000000000000002000000d000000000000000000000000000600000000000e0000000f000000000000000000000000
000800000010000000000000000006000000000000040000000000000000000008000000080000000000000000000d001100000a0000000000000000000000000000000b210000000000000000000000000300000000000003000000000f00080000000700000000000000000000000000000000000000050000000000000000
0b0000000008000000000000000000000000000400000004000000000000001000000000000000000000000000000d00000000000000000008000000000000000000000000000000000e0000000e000000000000000000000000000000000000000000000000000000000000000000000f000e00000000000000000000040400
0000100000000010090000000000000000040000000000000004000000000800000000100000080000000000000b0000000000000000000000000000000000002300000000000000000000000000000000000000000000000000000d000000000000000000000022000000220000000000000000000000000000000000000000
0000000800000000000000000000000000000000000000000000000000000000000800000000000000000000000b000000000000000000000000000000040000000000000000000e0000000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b00000000000000000000000500050022000022000022000022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010800001f14000000000002614000000000002b14000000000001f14000000000002b14000000000001f14000000000002614000000000002b14000000000001f14000000000002614000000000002b14000000
010800001333013330000001332013320000001331013310000001331013310000001331013310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01080000000002214000000000002114000000000001d14000000000001a14000000000001d14000000000001f14000000000002614000000000002b14000000000001f14000000000002b14000000000001f140
0108000000000000002614000000000002b14000000000001f14000000000002614000000000002b14000000000002214000000000002114000000000001d14000000000001a14000000000001d1400000000000
010800001333013330000001332013320000001331013310000001331013310000001331013310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000000000000000000000000000000000743007430074300743000000000000743000000000000743007430000000000000000000000743000000000000743007430074300743000000000000743000000
01080000000000000000000000001333013330000001533015330000001532015320000001633016330000000f3300f330000000f3200f320000000f3100f310000000f3100f310000000f3100f3100000000000
010800000000007430074300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003430034300343003430000000000003430000000000003430
010800000000000000000000000000000000000000000000113301133000000113201132000000113101131000000113101131000000113101131000000000000000000000113301133000000113201132000000
010800000343000000000000000000000034300000000000000000000000000000000000000000054300543005430054300000000000054300000000000054300543000000000000000000000000000000000000
010800000000000000000000000000000000000743007430074300743000000000000743000000000000743007430000000000000000000000743000000000000743007430074300743000000000000743000000
010800000343000000000000000000000034300000000000000000000000000000000000000000054300543005430054300000000000054300000000000054300543000000000000000000000000000000000000
010800000000000000000001624016240000002224022240000001624016240000002124021240000001624016240000001f2401f240000001624016240000001d2401d240000001f2401d2401b2401b24000000
010800000f3300f330000000f3200f320000000f3100f310000000f3100f310000000f3100f310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800001d2401d240000000000000000000001a2401a240000001b2401b240000001d2401d240000002124021240212402124000000000001f2401f240000001d2401d240000000000000000000001d2401d240
01080000000001f2401f2400000021240212400000021240212402124021240000000000022240222400000022240222402224022240222402224000000000000000022240222402224022240000000000022240
0108000022240222402224000000000001f2401f240000001f2401f2401f2401f2401f2401f240000000000000000222402224022240222400000000000242402424024240242400000000000212402124000000
010800002124021240212402124021240212400000000000000002424024240242402424000000000002524025240252402524000000000002224022240000002224022240222402224022240222400000000000
010800000000025240252402524025240000000000026240262400000023240232400000026240262400000027240272400000024240242400000027240272400000028240282400000025240252400000028240
0108000028240000002924029240000002624026240000002924029240000002f2403024031240322400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001333013330000001332013320000001331013310000001331013310000001331013310
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000743007430074300743000000000000743000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013330133300000015330153300000015320153200000016330
010800000000007430074300000000000000000000007430000000000007430074300743007430000000000007430000000000007430074300000000000000000000000000000000000000000000000000000000
0108000016330000000f3300f330000000f3200f320000000f3100f310000000f3100f310000000f3100f31000000000000000000000000000000000000000000000000000113301133000000113201132000000
010800000000000000000000000000000000000000000000034300343003430034300000000000034300000000000034300343000000000000000000000034300000000000000000000000000000000000000000
010800001131011310000001131011310000001131011310000000000000000000001133011330000001132011320000001333013330000001332013320000001331013310000001331013310000001331013310
010800000543005430054300543000000000000543000000000000543005430000000000000000000000000000000000000000000000000000000000000000000743007430074300743000000000000743000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016240162400000022240222400000016240162400000021240212400000016240
010800001131011310000001131011310000001131011310000000000000000000001133011330000001132011320000000f3300f330000000f3200f320000000f3100f310000000f3100f310000000f3100f310
010800000543005430054300543000000000000543000000000000543005430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0108000016240000001f2401f240000001624016240000001d2401d240000001f2401d2401b2401b240000001d2401d240000000000000000000001a2401a240000001b2401b240000001d2401d2400000021240
0108000021240212402124000000000001f2401f240000001d2401d240000000000000000000001d2401d240000001f2401f24000000212402124000000212402124021240212400000000000222402224000000
010800002224022240222402224022240222400000000000000002224022240222402224000000000002224022240222402224000000000001f2401f240000001f2401f2401f2401f2401f2401f2400000000000
010800000000022240222402224022240000000000024240242402424024240000000000021240212400000021240212402124021240212402124000000000000000024240242402424024240000000000025240
0108000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002b1402b14000000
0108000025240252402524000000000002224022240000002224022240222402224022240222400000000000000002524025240252402524000000000000000000000000002b2402b24000000262402624000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133301333000000133201332000000
010800002614026140000002414024140000001f1401f140000001a1401a140000001814018140000001314013140000000000000000000000000000000000000000000000000000000000000000000000000000
010800002424024240000001f2401f240000001a2401a240000001824018240000001324013240000000000000000000000000000000000002424024240242402424000000000002424024240242402424000000
010800001331013310000001331013310000001331013310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000000000000000000000000000000000000024240242402424024240000000000000000000000000000000000000000024240242402424024240000000000024240242402424024240000000000000000
0108000000000000000000000000000000000000000000000000000000000000000000000000001f14000000000002614000000000002b14000000000001f14000000000002b14000000000001f1400000000000
010800000000000000000000000000000242402424024240242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000000000000000000000000000000000000000000000000000000000000000000000000133301333000000133201332000000133101331000000133101331000000133101331000000000000000000000
010800002614000000000002b14000000000001f14000000000002614000000000002b14000000000002214000000000002114000000000001d14000000000001a14000000000001d14000000000001f14000000
01080000000002614000000000002b14000000000001f14000000000002b14000000000001f14000000000002614000000000002b14000000000001f14000000000002614000000000002b140000000000022140
0108000000000000002114000000000001d14000000000001a14000000000001d1400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000000000000000000000000000000000000000000000000000000000000000000000000133301333000000133201332000000133101331000000133101331000000133101331000000000000000000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074300743007430074300000000000074300000000000074300743000000
010a00001b3431b5331b533125000e500045001d7001b500145001450000000000000740000000000000740007400394000740000000000000740000000000000740007400074000740000000000000740000000
000200000c7500d7500e76014650106500e6300c6200a62008620066200562003610026100001000000000000000000000000000000000000000001a3001a3000000000000000000000000000000000000019300
01060000122330f2330c2330b2300a630086200562003610036100360007400000000000007400074000000000000000000000007400000000000000000000000000007400000000000007400000000000000000
010d00000545305453096460a6360b726057260371601700000000000000000153001530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400000762008640096500b6500c6500e6500f650106501364014640156301563016630176201762018620196201962019620196201a6201962019620196201862018620176101761016610156101460013600
0104000007440094400b6400f63014630196302063024630266202662024610216101b6100f6000a6000940009400094000940000000000000940000000000000940009400094000940000000000000940000000
01080000227522675229552205522854224532285222c5220d505115040f5030f5020f5040f5050f506000000000000000000000000000000000001c3001c3000000000000000000000000000000000000010300
010800000000009430000000000009430094300943009430000000000009430000000000009430094300000000000000000000009430000000000000000000000000000000000000000004430000000000000000
010800001033000000000000000000000113301133000000000000000000000123301233000000133301333000000133201332000000133101331000000133101331000000133101331000000000000000000000
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074300743007430074300000000000074300000000000074300743000000
010800000000009430000000000009430094300943009430000000000009430000000000009430094300000000000000000000009430000000000000000000000000000000000000000004430000000000000000
010800001033000000000000000000000113301133000000000000000000000123301233000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 00420144
00 02424344
00 03424344
00 41420405
00 41420607
00 41420809
00 4142040a
00 41420607
00 4142080b
00 410c0d44
00 410e4344
00 410f4344
00 41104344
00 41114344
00 41124344
00 41131415
00 41421617
00 41421819
00 41421a1b
00 41421617
00 41421819
00 411c1d1e
00 411f4344
00 41204344
00 41214344
00 41224344
00 23242544
02 26272844
00 41294344
00 2a2b2c44
00 2d424344
00 2e424344
00 2f423031
00 41424332
00 41423334
00 41423536
00 41424337
00 41423839
00 41423a3b
00 41424332
00 41423334
00 41423536
00 41424337
00 4142383c
00 41423d44
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

