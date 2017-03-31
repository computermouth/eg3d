--electric gryphon


--------------------------------------------------------------------------------------------------
--------------------------------------Model Definitions-------------------------------------------
--------------------------------------------------------------------------------------------------

--model definitions

--start with vector list: {x,y,z}
--and face list: {vertex1,vertex2,vertex3,color1,color2)
--face list numbers indicate the indeces of the vector list
--that make up the 3 corners of a triangle. If provided, the
--4th and 5th index are used to hold the two colors that make
--up the faces composite color. This is only necessary if you
--want to overide the shaded monochromatic color options.

--I have a series of find/replaces that converts an OBJ format
--exported from blender into these lists. If someone is in the
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


-------------------------------------------------------------BEGIN CUT HERE-------------------------------------------------
------------------------------------------------------Electric Gryphon's 3D Library-----------------------------------------
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



--These are used for the 2 scanline color shading scheme
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


k_ambient=.3
function color_faces(object,base)
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
	
end

					
function color_shade(color,brightness)
	--return double_color_list[ (color+1)*2-1 ][flr(brightness*10)] , double_color_list[ (color+1)*2 ][flr(brightness*10)] 
	local b= band(brightness*10,0xffff)
	local c= (color+1)*2
	return double_color_list[ c-1 ][b] , double_color_list[ c ][b] 
end			
	


light1_x=.1
light1_y=.35
light1_z=.2

--t_light gets written to
t_light_x=0
t_light_y=0
t_light_z=0

function init_light()
	light1_x,light1_y,light1_z=normalize(light1_x,light1_y,light1_z)
end

function update_light()
	t_light_x,t_light_y,t_light_z = rotate_cam_point(light1_x,light1_y,light1_z)
end

function normalize(x,y,z)
	local x1=shl(x,2)
	local y1=shl(y,2)
	local z1=shl(z,2)
	
	local inv_dist=1/sqrt(x1*x1+y1*y1+z1*z1)
	
	return x1*inv_dist,y1*inv_dist,z1*inv_dist
	
end

function	vector_dot_3d(ax,ay,az,bx,by,bz)
	return ax*bx+ay*by+az*bz
end
	
function	vector_cross_3d(px,py,pz,ax,ay,az,bx,by,bz)

	 ax-=px
	 ay-=py
	 az-=pz
	 bx-=px
	 by-=py
	 bz-=pz
	
	
	local dx=ay*bz-az*by
	local dy=az*bx-ax*bz
	local dz=ax*by-ay*bx
	return dx,dy,dz
end



k_colorize_static = 1
k_colorize_dynamic = 2
k_multi_color_static = 3
k_multi_color_dynamic = 4
k_preset_color = 5

--Function load object:
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

function load_object(object_vertices,object_faces,x,y,z,ax,ay,az,obstacle,color_mode,color)
	object=new_object()
	
	object.vertices=object_vertices
	
	
	--make local deep copy of faces 
	--if we don't car about on-demand shading we can share faces
	--but it means that objects will look wrong when rotated
	
	if(color_mode==k_preset_color)then
		object.faces=object_faces
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

	
	object.radius=0
	
	--make local deep copy of translated vertices
	--we share the initial vertices
	for i=1,#object_vertices do
		object.t_vertices[i]={}
			for j=1,3 do
				object.t_vertices[i][j]=object.vertices[i][j]
			end
	end

	object.ax=ax or 0
	object.ay=ay or 0
	object.az=az or 0
	
	transform_object(object)
	
	set_radius(object)
	set_bounding_box(object)
	
	object.x=x or 0
	object.y=y or 0
	object.z=z or 0
	
	object.color = color or 8
	object.color_mode= color_mode or k_colorize_static
	
	object.obstacle = obstacle or false
	
	if(obstacle)add(obstacle_list,object)
	
	if(color_mode==k_colorize_static or color_mode==k_colorize_dynamic or color_mode==k_multi_color_static )then
		color_faces(object,color)
	end

	
	
	return object
end

function set_radius(object)
	for vertex in all(object.vertices) do
		object.radius=max(object.radius,vertex[1]*vertex[1]+vertex[2]*vertex[2]+vertex[3]*vertex[3])
	end
	object.radius=sqrt(object.radius)
end

function set_bounding_box(object)
	for vertex in all(object.t_vertices) do
	
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

	add(triangle_list,{p1x=p1x,
	                   p1y=p1y,
	                   p2x=p2x,
	                   p2y=p2y,
	                   p3x=p3x,
	                   p3y=p3y,
	                   tz=z,
	                   c1=c1,
	                   c2=c2})
	
	
	
	
end

function draw_triangle_list()
	--for t in all(triangle_list) do
	for i=1,#triangle_list do
		local t=triangle_list[i]
		shade_trifill( t.p1x,t.p1y,t.p2x,t.p2y,t.p3x,t.p3y, t.c1,t.c2 )
	end
end

function update_visible(object)
		object.visible=false

		local px,py,pz = object.x-cam_x,object.y-cam_y,object.z-cam_z
		object.tx, object.ty, object.tz =rotate_cam_point(px,py,pz)

		object.sx,object.sy = project_point(object.tx,object.ty,object.tz)
		object.sradius=project_radius(object.radius,object.tz)
		object.visible= is_visible(object)
end

function cam_transform_object(object)
	if(object.visible)then

		for i=1, #object.vertices do
			local vertex=object.t_vertices[i]

			vertex[1]+=object.x - cam_x
			vertex[2]+=object.y - cam_y
			vertex[3]+=object.z - cam_z
			
			vertex[1],vertex[2],vertex[3]=rotate_cam_point(vertex[1],vertex[2],vertex[3])
		
		end
	

	end
end

function transform_object(object)
	

		
	
	if(object.visible)then
		generate_matrix_transform(object.ax,object.ay,object.az)
		for i=1, #object.vertices do
			local t_vertex=object.t_vertices[i]
			local vertex=object.vertices[i]
			
			t_vertex[1],t_vertex[2],t_vertex[3]=rotate_point(vertex[1],vertex[2],vertex[3])
		
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

		--uh yeah I looked this one up :-)
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

	--project all points in object to screen space
	--it's faster to go through the array linearly than to use a for all()
	for i=1, #object.t_vertices do
		local vertex=object.t_vertices[i]
		vertex[4],vertex[5] = vertex[1]*k_screen_scale/vertex[3]+k_x_center,vertex[2]*k_screen_scale/vertex[3]+k_x_center
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
		
		
		
		
		if(object.background==true) z_paint-=1000 
		face[6]=z_paint
		

		if((p1z>z_max or p2z>z_max or p3z>z_max))then
			if(p1z< z_clip and p2z< z_clip and p3z< z_clip)then
			--simple option -- no clipping required

					local s1x,s1y = p1[4],p1[5]
					local s2x,s2y = p2[4],p2[5]
					local s3x,s3y = p3[4],p3[5]
		

					if( max(s3x,max(s1x,s2x))>0 and min(s3x,min(s1x,s2x))<128)  then
						--only use backface culling on simple option without clipping
						--check if triangles are backwards by cross of two vectors
						if(( (s1x-s2x)*(s3y-s2y)-(s1y-s2y)*(s3x-s2x)) < 0)then
						
							if(object.color_mode==k_colorize_dynamic)then
								--nx,ny,nz = vector_cross_3d(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
								--save a bit on dynamic rendering by moving this funciton inline
								p2x-=p1x p2y-=p1y p2z-=p1z	
								p3x-=p1x p3y-=p1y p3z-=p1z	
								local nx = p2y*p3z-p2z*p3y
								local ny = p2z*p3x-p2x*p3z
								local nz = p2x*p3y-p2y*p3x
								
								--nx,ny,nz = normalize(nx,ny,nz)
								--save a bit by moving this function inline
								nx=shl(nx,2) ny=shl(ny,2) nz=shl(nz,2)
								local inv_dist=1/sqrt(nx*nx+ny*ny+nz*nz)
								nx*=inv_dist ny*=inv_dist nz*=inv_dist						
															
								
								--b = vector_dot_3d(nx,ny,nz,t_light_x,t_light_y,t_light_z)
								--save a bit by moving this function inline
								face[4],face[5]=color_shade(object.color, mid( nx*t_light_x+ny*t_light_y+nz*t_light_z,0,1)*(1-k_ambient)+k_ambient )
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


end

function three_point_sort(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)
	if(p1z>p2z) p1z,p2z = p2z,p1z p1x,p2x = p2x,p1x p1y,p2y = p2y,p1y
	if(p1z>p3z) p1z,p3z = p3z,p1z p1x,p3x = p3x,p1x p1y,p3y = p3y,p1y
	if(p2z>p3z) p2z,p3z = p3z,p2z p2x,p3x = p3x,p2x p2y,p3y = p3y,p2y
	
	return p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z
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



function lerp(a,b,alpha)
  return a*(1.0-alpha)+b*alpha
end

function handle_buttons()
	
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
	
end

function init_player()
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
end

k_friction=.7
function update_player()
	
	old_x=player.x
	old_y=player.y
	old_z=player.z

	

	player.y+=player.vy
	

	
	player.x+=player.vx
	for object in all(obstacle_list) do
		if( intersect_bounding_box(player, object)) player.vx=0 player.x=old_x 
	end
	player.z+=player.vz
	for object in all(obstacle_list) do
		if( intersect_bounding_box(player, object)) player.vz=0 player.z=old_z 
	end
	
	
	player.vx*=k_friction
	player.vy*=k_friction
	player.vz*=k_friction
end

function update_camera()	
	cam_x=player.x
	cam_y=player.y
	cam_z=player.z

	cam_ax=player.ax
	cam_ay=player.ay
	cam_az=player.az

	generate_cam_matrix_transform(cam_ax,cam_ay,cam_az)
end

function init_3d()
	init_player()
	init_light()
	object_list={}
	obstacle_list={}
	particle_list={}
end

function update_3d()
	for object in all(object_list) do
			update_visible(object)
			transform_object(object)
			cam_transform_object(object)
			update_light()
	end
end

function draw_3d()
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
end


function shade_trifill( x1,y1,x2,y2,x3,y3, color1, color2)

		  local x1=band(x1,0xffff)
		  local x2=band(x2,0xffff)
		  local y1=band(y1,0xffff)
		  local y2=band(y2,0xffff)
		  local x3=band(x3,0xffff)
		  local y3=band(y3,0xffff)
		  
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
		  
		 if(y1!=y2)then 		 
			local delta_sx=(x3-x1)/(y3-y1)
			local delta_ex=(x2-x1)/(y2-y1)
			
			if(y1>0)then
				nsx=x1
				nex=x1
				min_y=y1
			else --top edge clip
				nsx=x1-delta_sx*y1
				nex=x1-delta_ex*y1
				min_y=0
			end
			
			max_y=min(y2,128)
			
			for y=min_y,max_y-1 do

			--rectfill(nsx,y,nex,y,color1)
			if(band(y,1)==0)then rectfill(nsx,y,nex,y,color1) else rectfill(nsx,y,nex,y,color2) end
			nsx+=delta_sx
			nex+=delta_ex
			end

		else --where top edge is horizontal
			nsx=x1
			nex=x2
		end

		  
		if(y3!=y2)then
			local delta_sx=(x3-x1)/(y3-y1)
			local delta_ex=(x3-x2)/(y3-y2)
			
			min_y=y2
			max_y=min(y3,128)
			if(y2<0)then
				nex=x2-delta_ex*y2
				nsx=x1-delta_sx*y1
				min_y=0
			end
			
			 for y=min_y,max_y do

				--rectfill(nsx,y,nex,y,color1)
				if(band(y,1)==0)then rectfill(nsx,y,nex,y,color1) else rectfill(nsx,y,nex,y,color2) end
				nex+=delta_ex
				nsx+=delta_sx
			 end
			
		else --where bottom edge is horizontal
			--rectfill(nsx,y3,nex,y3,color1)
			if(band(y,1)==0)then rectfill(nsx,y3,nex,y3,color1) else rectfill(nsx,y3,nex,y3,color2) end
		end

end


----------------------------------END COPY-------------------------------------------------------
----------------------------------Electric Gryphon's 3D Library----------------------------------
-------------------------------------------------------------------------------------------------


function center_text(text,x,y,c)
	x=x-#text/2*4
	print(text,x,y,1)
	print(text,x+1,y,1)
	print(text,x,y-1,1)
	print(text,x,y+1,1)
	
	
	print(text,x,y,c)
end



function init_stars()
	star_list={}
	for i=1,150 do
		star_list[i]={}
		star_list[i].x=rnd(508)
		star_list[i].y=rnd(55)
	end
end

function draw_stars()
	for i=1,#star_list do
		pset((-cam_ay*508+star_list[i].x+cur_frame/20)%508,star_list[i].y,15)
	end
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

function load_temple()
	
	init_stars()

	for i=1,5 do
		l=30
		x=sin(i/5)*l
		z=cos(i/5)*l
		c=load_object(read_vector_string(column_v_string),read_face_string(column_f_string),x,0,z,0,0,0,true,k_colorize_static,9)--load models
	end
	
	fnt=load_object(read_vector_string(fountain_v_string),read_face_string(fountain_f_string),0,0,0,0,.08,0,true,k_colorize_static,14)
	hole=load_object(read_vector_string(hole_v_string),read_face_string(hole_f_string),0,11,0,.125,.125,.125,false,k_colorize_dynamic,12)
	
	pyramids={}
	for i=1,5 do
		l=25
		a=i/5+.125
		x=sin(a)*l
		z=cos(a)*l
		pyramids[i]=load_object(read_vector_string(pyramid_v_string),read_face_string(pyramid_f_string),x,0,z,0,0,0,false,k_colorize_static,13)
	end
end

function update_temple()
	hole.ay+=-.004 --dynamically adjust object parameters to make them move each frame
	hole.az+=.001
	hole.ax+=.002
	hole.y=11+sin(cur_frame/100)
	
	for i=1,5 do
		l=35
		a=i/5+.125+cur_frame/1000
		x=sin(a)*l
		z=cos(a)*l
		pyramids[i].x=sin(a)*l pyramids[i].z=cos(a)*l
		pyramids[i].y=10+sin(a-cur_frame/200)*4
		pyramids[i].ax+=.003 pyramids[i].ay+=.002 pyramids[i].az+=.004
	end
end

function draw_temple_background()
	rectfill(0,0,127,64,14)
	draw_stars()

	
	rectfill(0,64,127,127,5)
	
	for i=0,2 do
		rectfill(0,66+i*2,127,66+i*2,6)
		rectfill(0,60-i*2,127,60-i*2,15)
	end
end

function init_stars()
	star_list={}
	for i=1,150 do
		star_list[i]={}
		star_list[i].x=rnd(508)
		star_list[i].y=rnd(55)
	end
end

function draw_stars()
	for i=1,#star_list do
		pset((-cam_ay*508+star_list[i].x+cur_frame/20)%508,star_list[i].y,15)
	end
end

function draw_fox_background()
	cls(9)
	
	srand(2)
	for i=1,8 do
		circfill((rnd(167)+cur_frame)%167-20,rnd(167),rnd(20),10)
	end

end



function load_scene(init_func,update_func,background_func)
	scene_update_func=update_func
	scene_background_function=background_func
	init_3d()
	init_func()
end

scene_index=1
scene_list={{load_fox_dynamic,update_fox_dynamic,draw_fox_background},
			{load_temple,update_temple,draw_temple_background},
			{load_factory,update_factory,draw_factory_background}}

function _init()
	cur_frame=0

	
	init_3d() --Need to call init_3d() to set up player, camera and lights

	load_scene(load_fox_dynamic,update_fox_dynamic,draw_fox_background)

end


function _update()
	
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

end



function _draw()
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

end

--~ In _init() function include:
--~ --init_3d() --Need to call init_3d() to set up player, camera and lights
--~ --use load_object(object_vertices,object_faces,x,y,z,ax,ay,az,obstacle,color_mode,color) to load 3D models into the world
--~ --use read_vector_string and read_face_string to generate vertex list and face list from string data

--~ In _update() function include:
--~ --handle_buttons() -- handle default buttons for player-- this can be overwritten obviously.
--~ --update_player() -- update the player with default movement, stopping at obstacles
--~ --update_camera() -- update the camera based on player location and direction
--~ --update_particles() --update 3D particles if used. (I didn't add any for this demo.)
--~ --...
--~ --update_3d() -- call update_3d() at the end of the _update() function to transform etc.

--~ in _draw() function include:
--~ --draw_3d() --render objects into triangles, sort the triangles and draw them onto the screen
