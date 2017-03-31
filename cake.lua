-- cake factory
-- by ryosuke mihara

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

function dynamic_color_face(face,color)

end

function color_shade(color,brightness)
 return double_color_list[ (color+1)*2-1 ][flr(brightness*10)] , double_color_list[ (color+1)*2 ][flr(brightness*10)] 
end			



light1_x=.1
light1_y=.35
light1_z=.2

t_light_x=-01
t_light_y=.035
t_light_z=-.025

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

   object.t_vertices[i][1]+=object.x - cam_x
   object.t_vertices[i][2]+=object.y - cam_y
   object.t_vertices[i][3]+=object.z - cam_z
   
   object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3]=rotate_cam_point(object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3])
   
  end
  

 end
end

function transform_object(object)
 

 
 
 if(object.visible)then
  generate_matrix_transform(object.ax,object.ay,object.az)
  for i=1, #object.vertices do
   object.t_vertices[i][1],object.t_vertices[i][2],object.t_vertices[i][3]=rotate_point(object.vertices[i][1],object.vertices[i][2],object.vertices[i][3])
   
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
  face[6]=z_paint
  

  if((p1z>z_max or p2z>z_max or p3z>z_max))then
   if(p1z< z_clip and p2z< z_clip and p3z< z_clip)then
    --simple option -- no clipping required
    local s1x,s1y = project_point(p1x,p1y,p1z)
    local s2x,s2y = project_point(p2x,p2y,p2z)
    local s3x,s3y = project_point(p3x,p3y,p3z)

    if( max(s3x,max(s1x,s2x))>0 and min(s3x,min(s1x,s2x))<128)  then
     --only use backface culling on simple option without clipping
     if(( (s1x-s2x)*(s3y-s2y)-(s1y-s2y)*(s3x-s2x)) < 0)then
      
      if(object.color_mode==k_colorize_dynamic)then
       nx,ny,nz = vector_cross_3d(p1x,p1y,p1z,
				  p2x,p2y,p2z,
				  p3x,p3y,p3z)
       nx,ny,nz = normalize(nx,ny,nz)
       b = vector_dot_3d(nx,ny,nz,t_light_x,t_light_y,t_light_z)
       face[4],face[5]=color_shade(object.color, mid( b,0,1)*(1-k_ambient)+k_ambient )
      end
      
      
      new_triangle(s1x,s1y,s2x,s2y,s3x,s3y,z_paint,face[k_color1],face[k_color2])
     else
      --new_triangle(s1x,s1y,s2x,s2y,s3x,s3y,z_paint,8,8)
      --print(s1x..","..s1y.." "..s2x..","..s2y.." "..s3x..","..s3y,64,64,7)
      --flip()
     end
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
  local j = i
  while j > 1 and object_list[j-1].tz > object_list[j].tz do 
   object_list[j],object_list[j-1] = object_list[j-1],object_list[j]
   j = j - 1
  end
 end
end

function sort_faces(object)
 --for i=1,#a do
 local faces=object.faces
 
 for i=1,#faces do
  local j = i
  while j > 1 and faces[i][6] > faces[j][6] do 
   faces[j],faces[j-1] = faces[j-1],faces[j]
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

 
 local x1=band(x1,0xffff)
 local x2=band(x2,0xffff)
 local y1=band(y1,0xffff)
 local y2=band(y2,0xffff)
 local x3=band(x3,0xffff)
 local y3=band(y3,0xffff)
 
 -- order triangle points so that y1 is on top	  
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

function handle_buttons()
 if phase==0 then
  if btnp(4) then 
   start_game()
   phase=1 
  end
  return
 end
 if life<1 then
  if btnp(4) then run() end
  return
 end
 if btnp(4) then
  shoot_berry()
 end
 
-- if(btn(0))then
--  player.ay+=-.01
-- end
 
-- if(btn(1))then
--  player.ay+=.01
-- end
 
-- generate_matrix_transform(cam_ax,cam_ay,cam_az)
-- matrix_inverse()
-- vx,vy,vz=rotate_point(0,0,.2)
 
-- if(btn(2))then
  
--  player.vx=-vx
--  player.vy=-vy
--  player.vz=-vz
  

-- end
 
-- if(btn(3))then

--  player.vx=vx
--  player.vy=vy
--  player.vz=vz
-- end
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
 sort_object_list()
 for object in all(object_list) do
  
  if(object.visible and not object.background) then
   render_object(object) --sort_faces(object)
   --if(object.color_mode==k_colorize_dynamic or object.color_mode==k_multi_color_dynamic) color_faces(object,object.color)
  end
 end
 sort_triangle_list()
 draw_triangle_list()
end

function new_particle(x,y,z,vx,vy,vz,life,color)
 particle_vertices={{-.1,0,0},{.1,0,0},{0,.1,0}}
 particle_faces={{1,2,3,color,color},
  {1,3,2,color,color}}

 s=load_object(particle_vertices,particle_faces,x,y,z,0,-cam_ay,0,k_preset_color)

 
 s.vx=vx
 s.vy=vy
 s.vz=vz

 
 s.life=life
 add(particle_list,s)
end

k_particle_gravity=.01
function update_particles()
 for particle in all(particle_list) do
  
  particle.vy-=.047
  
  particle.x+=particle.vx
  particle.y+=particle.vy
  particle.z+=particle.vz
  
  
  particle.life-=1
  
  --	s.az+=.03
  --s.ay+=.02
  
  if(particle.life<=0)delete_object(particle) del(particle_list,particle)
 end
end

----------------------------------end copy-------------------------------------------------------
----------------------------------electric gryphon's 3d library----------------------------------
-------------------------------------------------------------------------------------------------

--

cake_v = {
 {-1.5,0,0}, -- 1
 {1.5,-1,0}, -- 2
 {1.5,1,0},  -- 3

 {-1.5,0,-0.3}, -- 4
 {1.5,-1,-0.3}, -- 5
 {1.5,1,-0.3},  -- 6

 {-1.5,0,-0.7}, -- 7
 {1.5,-1,-0.7}, -- 8
 {1.5,1,-0.7},  -- 9

 {-1.5,0,-1}, -- 10
 {1.5,-1,-1}, -- 11
 {1.5,1,-1}   -- 12
}

cake_f = {
 -- top
 {1,2,3,7,7},
 -- bottom
 {10,12,11,9,9},

 -- side1
 {1,4,2,10,10},
 {4,5,2,10,10},
 {4,7,5,7,7},
 {7,8,5,7,7},
 {7,10,8,10,10},
 {10,11,8,10,10},

 -- side2
 {1,3,6,10,10},
 {6,4,1,10,10},
 {4,6,9,7,7},
 {9,7,4,7,7},
 {7,9,12,10,10},
 {12,10,7,10,10},

 -- back
 {3,2,11,7,7},
 {11,12,3,7,7}
}

function bake_cake(x,y,z,ax,ay,az)
 local v=cake_v
 local f=cake_f
 return load_object(v,f,x,y,z,ax,ay,az,false,k_preset_color)
end

function make_berry(x,y,z,ax,ay,az)
 local cx=0.0
 local cy=0.0
 local topz=0.6
 local bottomz=-0.1
 local vertices={}
 local faces={}
 local topi=1
 local bottomi=2
 add(vertices, {cx,cy,topz})
 add(vertices, {cx,cy,bottomz})
 local rot=0.0
 local radius=0.5
 local n=2
 local col=8
 local i=bottomi
 for rot=0,2.1,0.1 do
  local x=cx+radius*cos(rot)
  local y=cy+radius*sin(rot)
  add(vertices, {x,y,0.0})
  i+=1
  n-=1
  if n==0 then
   if rot>1.0 then
    col=14
   end
   add(faces, {topi,i-1,i-2,8,col})
   add(faces, {bottomi,i-2,i-1,8,col})
   n=2
   i-=1
  end
 end
 return load_object(vertices,faces,x,y,z,ax,ay,az)
end

--

function add_ptcl(b)
 local deg=rnd(1.0)
 local spd=rnd(0.5)+0.25
 local vx=spd*cos(deg)
 local vy=0.5
 local vz=spd*sin(deg)
 new_particle(b.x,b.y,b.z,vx,vy,vz,rnd(15),8)
end

--
g=-0.0098
berries={}
berry_spd=0.25
berry_ready=true
function shoot_berry()
 if not berry_ready then
  return
 end
 berry_ready=false
 sfx(0)
 local b=make_berry(-1.5,0.5,player.z-2.5,0,0,0)
 b.ax=rnd(1.0)
 b.ay=rnd(1.0)
 b.az=rnd(1.0)
 local deg=-0.125
 b.vx=0.05
 b.vy=berry_spd*sin(deg)
 b.vz=-berry_spd*cos(deg)
 b.cake=nil
 b.dx=nil
 b.dy=nil
 b.dz=nil
 add(berries,b)
end

function collide(berry)
 for cake in all(cakes) do
  local dx=cake.x-berry.x
  local dy=cake.y-berry.y
  local dz=cake.z-berry.z
  if abs(dx)+abs(dy)+abs(dz)<1 then
   return cake
  end
 end
 return nil
end

function update_berry(berry)
 if berry.cake ~= nil then
  berry.x=berry.cake.x-berry.dx
  berry.y=berry.cake.y-berry.dy
  berry.z=berry.cake.z-berry.dz
  return
 end
 berry.vy+=g
 berry.x+=berry.vx
 berry.y+=berry.vy
 berry.z+=berry.vz
 berry.ax+=0.01
 berry.ay+=0.01
 berry.az+=0.01
 local cake=collide(berry)
 if cake ~= nil then
  sfx(2)
  cash+=2
  berry.cake=cake
  berry.dx=cake.x-berry.x
  berry.dy=cake.y-berry.y
  berry.dz=cake.z-berry.z
  cake.berry=berry
  berry_ready=true
 elseif berry.y<-1.0 then
  sfx(1)
  shake=14
  life-=1
  if life<1 then
   music(-1)
   sfx(8)
  end
  for i=0,20,1 do
  add_ptcl(berry)
  end
  delete_object(berry)
  del(berries,berry)
  berry_ready=true
 end
end

--

function start_game()
 music(0)
end

--

label_image=false
function _init()
 shake=0
 life=3
 cash=0
 phase=0
 cakes={}
 cur_frame=0
 init_3d() --need to call init_3d() to set up player, camera and lights
 player.y=4
 player.ax=-0.089
 --
 if label_image then
  phase=1
  bake_cake(-0.3,2,11,0.275,0,0)
  make_berry(0.4,2,11,0.275,0,0.15)
 end
end


function _update()
 handle_buttons() -- handle default buttons for player-- this can be overwritten obviously.
 update_player() -- update the player with default movement, stopping at obstacles
 update_camera() -- update the camera based on player location and direction
 update_particles() --update 3d particles if used. (i didn't add any for this demo.)
 update_3d() -- call update_3d() at the end of the _update() function to transform etc.

 if label_image then return end

 if cur_frame%80==0 then
  local c=bake_cake(0,0,-10,0.25,0,0)
  c.az+=rnd(1.0)
  c.berry=nil
  add(cakes,c)
 end

 for cake in all(cakes) do
  cake.z+=0.15
  if cake.berry ~= nil then
   cake.ax-=0.02
   cake.berry.ax-=0.02
  end
  if cake.z>15 then
   if cake.berry ~= nil then
    delete_object(cake.berry)
    del(berries,cake.berry)
   end
   delete_object(cake)
   del(cakes,cake)
  end
 end

 for berry in all(berries) do
  update_berry(berry)
 end

 cur_frame+=1
 if shake>0 then 
  shake-=1
  if shake==0 then
   camera(0,0)
  end
 end
end

bcols={0,1,13,14}
function _draw()
 rectfill(0,0,127,127,bcols[life+1])  

 draw_3d() --render objects into triangles, sort the triangles and draw them onto the screen

 if label_image then return end

 if shake>0 then
  camera(rnd(8.0)-4.0,rnd(8.0)-4.0)
 end

 -- gameover
 if life<1 or phase==0 then
  local pw=4
  for x=0,127,pw do
   for y=0,127,pw do
    rectfill(x,y,x+pw-1,y+pw-1,pget(x,y))
   end
  end
 end

 if life<1 then
  rectfill(31,54,97,64,0)
  print("gameover",49,57,7)
 end

 if phase==0 then
  rectfill(31,47,97,71,13)
  print("welcome to",45,49,7)
  print("the cake factory",33,57,7)
  print("press z to start",33,65,7)
 end

 -- cash
 if phase>0 then
  print("$"..cash,2,2,7)
 end

 --print(#object_list,0,104,7)
 --print(#berries,0,112,7)
 --print(#cakes,0,120,7)
end
