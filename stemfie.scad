// LibFile: stemfie.scad 
// Includes:
//   include <stemfie.scad>
// DefineHeader(Label): Author
// DefineHeader(Label): Contact
// DefineHeader(Label): Licence
// Description:
//   Author: Brendon Collecutt
//   Contact: 1976016983@qq.com
//   .
//   Licence : Creative Commons - Attribution Sharealike 4.0
//   .
//   OpenSCAD script for creating Stemife.org parts
//   Feel free to adapt and improve and share your OpenSCAD script (please contact Paulo Kiefe)
//   Contact: paulo.kiefe@stemfie.org (https://stemfie.org)


//Universal constants

// Constant: BU
// Description: Universal voxel block unit (mm) in Stemfie (BlockUnit)
BU = 12.5;
// Constant:HoleRadius
// Description: Universal radius (mm) of the connection hole
HoleRadius = 3.5;
// Constant: FragmentNumber
// Description: Universal tesselation value of curved surfaces
FragmentNumber = 32;

// Constant: Chamfer
// Description: Chamfer size adjustment value for all edges
Chamfer = 0.30;

// Constant: BevelWidth
// Description: Width of the top section of beveled edges. Must be less or equal to 
//   twice printer nozzle diameter to ensure level top surface.
BevelWidth = 0.8;

// Constant: Clearance
// Description: Distance between hole and shafts and
//   other parts that need to move relatively to each other.
Clearance = 0.19;

// Constant: ShaftRadius
// Description: Universal radius (mm) of the connection shaft
ShaftRadius = HoleRadius - Clearance;

// Constant: ShaftFlat
// Description: Universal distance (mm) between two flat sides of the connection shaft.
ShaftFlat = 5;


$fn = FragmentNumber;
//color("lightgreen")
//beam_block(d = [3, 2, 1], holes = [1, 1 , 1]);

//brace_cross(lengths = [3,1,2,1]);
//beam_cross(lengths = [2]);
//brace_arc_blank(5, angle = 90);
//BU_slot(2);
//shaft_head();
//shaft_profile();
//brace(3);

// Module: shaft_profile()
// Usage:
//   shaft_profile();
// Description:
//   Creates a stemfie 2D profile for creating shafts and screws.
// Example(2D):
//   shaft_profile();
module shaft_profile()
{
    I()
    {
        Ci(r = ShaftRadius);
        Sq(ShaftFlat, ShaftRadius * 3);
    }
}

// Module: shaft_head_profile()
// Usage: 
//   shaft_head_profile()
// Description:
//   Creats a stemfie 2D profile for creating shafts and screw heads.
// Example(2D):
//   shaft_head_profile();
module shaft_head_profile()
{
    offset(r = 1)
    offset(-1)
    I()
    {
        Tx(-1)
        Ci(r = BU/2);
        Tx(BU/2)
        Sq(BU);
    }
}

// Module: shaft_head()
// Usage: 
//   shaft_head()
// Description:
//   Creats a stemfie shaft or screw head for creating shafts and screws.
// Example():
//   shaft_head();
module shaft_head()
{
    hull()
    {
        LiEx(ShaftFlat - Chamfer * 2)
            shaft_head_profile();
        LiEx(ShaftFlat)offset(-Chamfer)
            shaft_head_profile();
    }
    Ry(90)
    LiEx(Chamfer * 2, C = false)
    shaft_profile();
}

// Module: shaft()
// Usage:
//   shaft(l, beveled_ends)
// Description:
//   Creates a stemfie blank shaft for creating shafts and screws.
// Arguments:
//   l = The length of the shaft in base units.
//   beveled_ends = Bevel ends of shaft using the global {{Chamfer}} setting.
// Example(3D): Shaft with beveled ends
//   shaft(4, true);
// Example(3D): Shaft without beveled ends
//   shaft(4, false);
module shaft(l = 1, beveled_ends = true)
{
    Ry(90)
    D()
    {
        U()
        {
            LiEx(l * BU - (beveled_ends?Chamfer * 2:0))
            {
                shaft_profile();
            }
            
            if(beveled_ends)
            MKz()
            Tz(l * BU / 2)
                bevel(neg = false)
                    shaft_profile();
        }
    }
}

// Module: shaft_with_hole()
// Usage:
//   shaft_with_hole(l, d)
// Description:
//   Stemfie blank shaft for creating shafts and screws.
// Arguments:
//   l = Length of shaft.
//   d = Diameter of hole through shaft.
//   beveled_ends = Bevel ends of shaft using the global {{Chamfer}} setting.
// Example(3D):
//   shaft_with_hole(4);
// Example(3D):
//   shaft_with_hole(4, 1.2, false);
module shaft_with_hole(l = 1, d = 2.1, beveled_ends = true)
{
    D()
    {
        shaft(l, beveled_ends);
        Ry(90)
        cutout(l, true)
            Ci(d = d);
    }
}


// Module: hole()
// Usage:
//   hole(l, neg);
// Description:
//   Create a circular standard sized hole with beveled top and bottom.
// Arguments:
//   l = The length of the hole in base units.
//   neg = true to create hole cavity, false to create sleeve and bevel.
// Example(3D):
//   D()
//   {
//     BU_cube();
//     hole(l = 1, neg = true);
//   }
// Example(3D):
//   hole(l = 1, neg = false);
// Example(3D):
//   D()
//   {
//     hole(l = 1, neg = false);
//     hole(l = 1, neg = true);
//   }
module hole(l = 1, neg = true)
{
    cutout(l, neg)
        Ci(r = HoleRadius);
}

// Module: cutout()
// Usage:
//   cutout(l, neg);
// Description:
//   Create an irregular sized hole with beveled top and bottom. Children should be a convex 2D shape.
// Arguments:
//   l = The length of the cutout in base units.
//   neg = true to create cutout cavity, false to create sleeve and top bevel.
// Example(3D):
//   cutout(l = 2, neg = true)
//     slot(l = 3);
// Example(3D): 
//   cutout(l = 2, neg = false);
//     slot(l = 3);
// Example(3D): Square hole
//   D()
//   {
//     cutout(l = 2, neg = false)
//       square(HoleRadius * 2, center = true);
//     cutout(l = 2, neg = true)
//       square(HoleRadius * 2, center = true);
//   }
module cutout(l = 1, neg = true)
{
    if(neg)
    {
        U()
        {
            LiEx(l * BU + 0.1)
                children();
            MKz()
                Tz((l * BU)/2)
                    bevel(true, 0)
                        children();
                   
        }
    }
    else
    {
        Tz(-Chamfer / 2)
        LiEx(h = l * BU - Chamfer)
            offset(Chamfer * 2 + BevelWidth)children();
        Tz((l * BU)/2)
            bevel(false, Chamfer * 2 + BevelWidth)
                children();
            
    }
}


module hole_grid(size = [1,1], l = 1, neg = true)
{
    forXY(N = size.x, M = size.y, dx = BU, dy = BU)
        hole(l = l, neg = neg);
}

module hole_list(list = [[0,0]], l = 1, neg = true)
{
    for(i = list)
        T(i.x * BU, i.y * BU, 0)
            hole(l = l, neg = neg);
}


// Module: hole_slot()
// Usage:
//   hole_slot(l);
// Description:
//   Create a 2D slot profile with radius HoleRadius
// Arguments:
//   l = Length of slot in block units.
// Example(2D):
//   hole_slot(2);
module hole_slot(l)
{
    slot(l, HoleRadius);
}

// Module: BU_slot()
// Usage:
//   BU_slot(l);
// Description:
//   Create a 2D slot profile with radius {{BU}}/2
// Arguments:
//   l = Length of slot in block units.
// Example(2D):
//   BU_slot(2);
module BU_slot(l)
{
    slot(l, BU/2);
}

// Module: slot()
// Usage:
//   slot(l, r);
// Description:
//   Create a 2D slot profile.
// Arguments:
//   l = Length of slot in block units.
// Example(2D):
//   slot(2);
module slot(l, r = BU/2)
{
    hull()
    {
        MKx()
            Tx(l*BU / 2 - BU / 2)
                Ci(r = r);
    }
}

module bevel(neg = true, offs = 0)
{
    offs = offs + (neg?Chamfer:0);
    Tz(neg?0:-Chamfer)
    Sz(neg?-1:1)
    hull()
    {
        Tz(-0.05)
            LiEx(0.1)
                offset(offs)
                children();
        
        Tz(Chamfer / 2)
        LiEx(Chamfer)
                offset(offs - Chamfer)
                children();
    }
}

module bevel_plate(h = 0.25)
{
    D()
    {
        hull()
        {
            LiEx(BU * h - Chamfer * 2)children();
            LiEx(BU * h)offset(r = -Chamfer)children();
        }

        Tz(BU * h / 2)
            bevel(true, -Chamfer * 2 - BevelWidth)children();

    }
}

module brace_cross_section(h = 0.25)
{
    
    D()
    {
        hull()
        {
            Sq(BU,h*BU - Chamfer*2);
            Sq(BU - Chamfer*2, h*BU);
        }
        
        
        hull()
        {
            Ty(h*BU/2 + 0.1)
                Sq(BU - Chamfer * 2 - BevelWidth*2, 0.2);
            Ty(h*BU/2)
                Sq(BU - Chamfer * 4 - BevelWidth*2, Chamfer * 2);
        }
    }
}

module brace_arc_blank(r, angle)
{
    
    rotate_extrude(angle=angle, convexity = 4, $fn = FragmentNumber * r * 2)
        Tx(r * BU)
        brace_cross_section();
    Tx(r * BU)
    I()
    {
        bevel_plate()
            Ci(BU/2);
        Ty(-BU/2)
            Cu(BU+1, BU, BU);
    }
            
}

module brace(l = 1, h = 0.25, hole_sizes=[1])
{
    num_holes = len(hole_sizes);
    
    Tx((l-1) * BU/2)
    D()
    {
        U()
        {
            bevel_plate(h)slot(l);
            hole_grid([l,1],h,false);
        }
        hole_grid([l,1],h,true);
    }
    
}

module brace_cross(lengths = [2,2,2,2])
{
    cross_helper(len(lengths))
    {
        brace(lengths[0] + 1);
        if(len(lengths) > 1)
            brace(lengths[1] + 1);
        if(len(lengths) > 2)
            brace(lengths[2] + 1);
        if(len(lengths) > 3)
            brace(lengths[3] + 1);
    }
}


module BU_cube(size = [1,1,1])
{
    D()
    {
        hull()
            for(i = [[0, 1, 1],[1, 0, 1],[1, 1, 0]])
                Cu(size * BU - i * Chamfer*2);
    }
}


module beam_cross(lengths = [2,2,2,2])
{
    cross_helper(len(lengths))
    {
        beam_block([lengths[0] + 1,1,1]);
        if(len(lengths) > 1)
            beam_block([lengths[1] + 1,1,1]);
        if(len(lengths) > 2)
            beam_block([lengths[2] + 1,1,1]);
        if(len(lengths) > 3)
            beam_block([lengths[3] + 1,1,1]);
    }
}

module cross_helper(num = 4)
{
    for(i = [0: max(3, num - 1)])
    {
        Rz(-90 * i)
        D()
        {
            children(i);
            if(num > 1)
            {
                if(num != 2 || i != 1)
                    Rz(num == 3 && i == 2?0:45)T(-BU)Cu(BU * 2);
                if(num != 2 || i != 0)
                    Rz(num == 3 && i == 0?0:-45)Tx(-BU)Cu(BU * 2);
            }
        }
    }

}

module beam_block(size = [5,1,1], holes =[1,1,1])
{
    faceRotate = [[0,90,0],[90,0,0],[0,0,90]];
    //Tz(size.z * BU/2)
    T((size - [1,1,1]) * BU / 2)
    D()
    {
        U()
        {

            D()
            {
                BU_cube(size);
                    Tz(size.z * BU / 2)
                    bevel(true, offs = -Chamfer * 2 - BevelWidth)
                    Sq(size.x * BU, size.y * BU);
            }
            
            hole_grid(size = [size.x, size.y], l = size.z, neg = false);
        }
        
        for(i = [0:2])
        {
            if(holes[i])
            R(faceRotate[i])
                hole_grid(size = [size[(i + 2) % 3], size[(i + 1) % 3]], l = size[i], neg = true);

        }

    }
}


/// https://www.thingiverse.com/thing:644830
/// ShortCuts.scad 
/// Author: Rudolf Huttary, Berlin 2015
/// Update: Dario Pellegrini, Padova (IT) 2019/8
///

/// Euclidean Transformations

module T(x=0, y=0, z=0){
  translate(x[0]==undef?[x, y, z]:x)children(); }
module TK(x=0, y=0, z=0){ children(); T(x,y,z) children(); }
  
module Tx(x) { translate([x, 0, 0])children(); }
module Ty(y) { translate([0, y, 0])children(); }
module Tz(z) { translate([0, 0, z])children(); }
module TKx(x) { TK(x=x) children(); }
module TKy(y) { TK(y=y) children(); }
module TKz(z) { TK(z=z) children(); }

module R(x=0, y=0, z=0) rotate( is_list(x)? x : [x, y, z]) children();
module Rx(x=90) for(i=(is_list(x)?x:[x])) R([i, 0, 0]) children();
module Ry(y=90) for(i=(is_list(y)?y:[y])) R([0, i, 0]) children();
module Rz(z=90) for(i=(is_list(z)?z:[z])) R([0, 0, i]) children();
module M(x=0, y=0, z=0) mirror( is_list(x)? x : [x, y, z]) children(); 
module Mx() M([1, 0, 0]) children(); 
module My() M([0, 1, 0]) children(); 
module Mz() M([0, 0, 1]) children(); 

module RK(x=0, y=0, z=0){children(); rotate( is_list(x)? x : [x, y, z]) children();}
module RKx(x=90) Rx(concat(0,x)) children();
module RKy(y=90) Ry(concat(0,y)) children();
module RKz(z=90) Rz(concat(0,z)) children();
module MK(x=0, y=0, z=0) {children(); mirror( is_list(x)? x : [x, y, z]) children();} 
module MKx() MK([1, 0, 0]) children(); 
module MKy() MK([0, 1, 0]) children(); 
module MKz() MK([0, 0, 1]) children(); 

module S(x=1, y=undef, z=undef){ scale(x[0]==undef?[x, y?y:x, z?z:y?1:x]:x) children();}
module Sx(x=1){scale([x, 1, 1]) children();}
module Sy(y=1){scale([1, y, 1]) children();}
module Sz(z=1){scale([1, 1, z]) children();}

module Skew(x=0, y=0, z=0, a=0, b=0, c=0)
  multmatrix([[1, a, x], [b, 1, y], [z, c, 1]]) children(); 
module skew(x=0, y=0, z=0, a=0, b=0, c=0) 
  Skew(x, y, z, a, b, c) children();
module SkX(x=0) Skew(x=x) children();
module SkY(y=0) Skew(y=y) children();
module SkZ(z=0) Skew(z=z) children();
module SkewX(x=0) Skew(x=x) children();
module SkewY(y=0) Skew(y=y) children();
module SkewZ(z=0) Skew(z=z) children();

module LiEx(h=1, tw = 0, sl = 20, sc = 1, C=true) linear_extrude(height=h, twist = tw, slices = sl, scale = sc, center=C) children();

// Booleans
module D() if($children >1) difference(){children(0); children([1:$children-1]);} else children(); 
module U() children([0:$children-1]);
module I() intersection_for(n=[0:$children-1]) children(n); 

// rotates N instances of children around z axis
module rotN(r=10, N=4, offs=0, M=undef) for($i=[0:(M?M-1:N-1)])  rotate([0,0,offs+$i*360/N])  translate([r,0,0]) children();
module forN(r=10, N=4, offs=0, M=undef) rotN(r, N, offs, M) children();
module forX(dx = 10, N=4) for(i=[0:N-1]) T(-((N-1)/2-i)*dx) children(); 
module forY(dy = 10, M=4) for(i=[0:M-1]) Ty(-((M-1)/2-i)*dy) children(); 
module forZ(dz = 10, M=4) for(i=[0:M-1]) Tz(-((M-1)/2-i)*dz) children(); 
module forXY(dx = 10, N=4, dy = 10, M=4) forX(dx, N) forY(dy, M) children(); 


// primitives - 2D

module Sq(x =10, y = undef, center = true)
{
		square([x, y?y:x], center = center); 
}
module Ci(r = 10, d=undef) circle(d?d/2:r); 

// derived primitives - 2d
module CiH(r = 10, w = 0, d=undef)
  circle_half(r, w, d); 

module CiS(r = 10, w1 = 0, w2 = 90, d=undef)
  circle_sector(r, w1, w2, d); 


// primitives - 3d
module Cy(r = undef, h = 1, C = true, r1 = undef, r2=undef, d=undef, d1=undef, d2=undef)
  cylinder(r=d?d/2:r, h=h, center=C, r1=d1?d1/2:r1, r2=d2?d2/2:r2); 

module Cu(x = 10, y = undef, z = undef, C = true)
  cube(x[0] == undef?[x, y?y:x, y?z?z:1:x]:x, center=C); 

module CuR(x = 10, y = undef, z = undef, r = 0, C = true)
  cube_rounded(x[0] == undef?[x, y?y:x, y?z?z:1:x]:x, r=r, center=C); 

module CyR(r = 10, h=10, r_=1, d = undef, r1=undef, r2=undef, d1 = undef, d2 = undef, C=false)  
  cylinder_rounded(r, h, r, d, r1, r2, d1, d2, C); 

// derived primitives - 3d
module CyH(r = 10, h = 1, w = 0, C = true, r1 = undef, r2=undef, d=undef, d1=undef, d2=undef)
  Rz(w) cylinder_half(r=r, h=h, center=C, r1=r1, r2=r2, d=d, d1=d1, d2=d2); 

module CyS(r = 10, h = 1, w1 = 0, w2 = 90, C = true, r1 = undef, r2=undef, d=undef, d1=undef, d2=undef)
  cylinder_sector(r=r, h=h, w1=w1, w2=w2, center=C, r1=r1, r2=r2, d=d, d1=d1, d2=d2); 

module Ri(R = 10, r = 5, h = 1, C = true, D=undef, d=undef)
  ring(R, r, h, C, D, d); 

module RiS(R = 10, r = 5, h = 1, w1 = 0, w2 = 90, C = true, D=undef, d=undef)
   ring_sector(R, r, h, w1, w2, C, D, d); 

module RiH(R = 10, r=5, h = 1, w = 0, C = true, D=undef, d=undef)
   ring_half(R, r, h, w, C, D, d); 
module Pie(r = 10, h = 1, w1 = 0, w2 = 90, C = true, d=undef)
  cylinder_sector(r, h, w1, w2, C, d);  
module Sp(r = 10)
  sphere(r); 
module SpH(r = 10, w1 = 0, w2 = 0)
  sphere_half(r, w1, w2); 
module To(R=10, r=1, r1 = undef, w=0, w1=0, w2=360) torus(R=R, r=r, r1=r1, w=w,w1=w1, w2=w2);  

module Col(r=1, g=1, b=1, t=1) 
{
  if(len(r)) 
    color(r, g) children(); 
  else
    color([r,g,b], t) children(); 
}

function Rg(N=10) = [for(i=[0:N-1]) i]; 

//


// clear text definitions

module cube_rounded(size, r=0, center=false)
{
  sz = size[0]==undef?[size, size, size]:size; 
  ce = center[0]==undef?[center, center, center]:center; 
  r_ = min(abs(r), abs(size.x/2), abs(size.y/2), abs(size.z/2)); 
  translate([ce.x?-sz.x/2:0,ce.y?-sz.y/2:0, ce.z?-sz.z/2:0])
  if(r)
    hull() 
    {
      translate([r_, r_, r_]) sphere(r_); 
      translate([r_, r_, sz.z-r_]) sphere(r_); 
      translate([r_, sz.y-r_, r_]) sphere(r_); 
      translate([r_, sz.y-r_, sz.z-r_]) sphere(r_); 
      translate([sz.x-r_, r_, r_]) sphere(r_); 
      translate([sz.x-r_, r_, sz.z-r_]) sphere(r_); 
      translate([sz.x-r_, sz.y-r_, r_]) sphere(r_); 
      translate([sz.x-r_, sz.y-r_, sz.z-r_]) sphere(r_); 
    }
  else 
    cube(size); 
}

module circle_half(r = 10, w = 0, d = undef)
{
  R= d?d/2:r;
	difference()
	{
		circle(R); 
     rotate([0, 0, w-90])
     translate([0, -R])
		square([R, 2*R], center = false); 
	}
}

module circle_sector(r = 10, w1 = 0, w2 = 90, d = undef)
{
  R = d?d/2:r; 
  W2 = (w1>w2)?w2+360:w2; 
  diff = abs(W2-w1);
  if (diff < 180)
    intersection()
		{
       circle_half(R, w1); 
       circle_half(R, W2-180); 
 		}
	else if(diff>=360)
    circle(R); 
  else
		{
       circle_half(R, w1); 
       circle_half(R, W2-180); 
 		}
}

module cylinder_half(r = 10, h = 1, center = true, r1 = undef, r2=undef, d=undef, d1=undef, d2=undef)
{
  R = max(d?d/2:r, r1?r1:0, r2?r2:0, d1?d1/2:0, d2?d2/2:0);
  difference()
  {
    Cy(r=r, h=h, C=center, r1=r1, r2=r2, d=d, d1=d1, d2=d2);
    Ty(-(R+1)/2)
    Cu(2*R+1, R+1, h+1, C = center); 
  }
//  linear_extrude(height = h, center = center)
//  circle_half(r=r, w=w, d=d); 
} 

module cylinder_sector(r = 10, h = 1, w1 = 0, w2 = 90, center = true, r1 = undef, r2=undef, d=undef, d1=undef, d2=undef)
{
  R = max(d?d/2:r, r1?r1:0, r2?r2:0, d1?d1/2:0, d2?d2/2:0);
    intersection()
    {
      Cy(r=r, h=h, C=center, r1=r1, r2=r2, d=d, d1=d1, d2=d2);
      cylinder_sector_(r=R, h=h, w1=w1, w2=w2, center=center);
    }
}

module cylinder_sector_(r = 10, h = 1, w1 = 0, w2 = 90, center = true)
  linear_extrude(height = h, center = center, convexity = 2)
  circle_sector(r=r, w1=w1, w2=w2); 

module cylinder_rounded(r=10, h=10, r_=1, d=undef, r1=undef, r2=undef, d1=undef, d2=undef, center=true)
{
  r1 = r1==undef?d1==undef?d==undef?r:d/2:d1/2:r1;
  r2 = r2==undef?d2==undef?d==undef?r:d/2:d2/2:r2;
  r_ = min(abs(h/4), abs(r1), abs(r2), abs(r_));
  h = abs(h);
  Tz(center?-h/2:0) rotate_extrude() I()
  {
    offset(r_)offset(-r_) polygon([[-2*r_,0], [r1, 0], [r2, h], [0,h], [-2*r_,h]] );
    Sq(max(r1,r2), h, 0);
  }
} 


module ring(R = 10, r = 5, h = 1, center = true, D=undef, d=undef)
  linear_extrude(height = h, center = center, convexity = 2)
	difference()
	{
    Ci(r = D?D/2:R); 
    Ci(r = d?d/2:r); 
	}


module ring_half(R = 10, r = 5, h = 1, w = 0, center = true, D=undef, d=undef)
  linear_extrude(height = h, center = center, convexity = 2)
  Rz(w)
	difference()
	{
    CiH(r = D?D/2:R); 
    Ci(r = d?d/2:r); 
	}

module ring_sector(R = 10, r = 5, h = 1, w1 = 0, w2 = 90, center = true, D=undef, d=undef)
  linear_extrude(height = h, center = center, convexity = 2)
	difference()
	{
    CiS(r = D?D/2:R, w1 = w1, w2 = w2); 
    Ci(r = d?d/2:r); 
	}


module sphere_half(r = 10, w1 = 0, w2 = 0)
  R(w1, w2)
	intersection() {
   	sphere(r);
    Tz(r) Cu(2*r); 
	}

module torus(R=10, r=1, r1 = undef, w=0, w1=0, w2=360)
{
  if (r1)
    D(){
      To(R=R, r=r, w=w, w1=w1, w2=w2); 
      To(R=R, r=r1, w=w, w1=w1-1, w2=w2+1); 
    }
  else
    Rz(w1)
    rotate_extrude(angle = w2-w1)
    T(R)
    Rz(w)
    circle(r); 
    
}

// additional code
module place_in_rect(dx =20, dy=20)
{
  cols = ceil(sqrt($children)); 
  rows = floor(sqrt($children)); 
  for(i = [0:$children-1])
	{ 
	  T(dx*(-cols/2+(i%cols)+.5), dy*(rows/2-floor(i/cols)-.5))
		 children(i); 
	}
}

module measure(s=10, x=undef, y=undef, z=undef)
{
  p=[[s, s, 0], [-s, s, 0], [-s, -s, 0], [s, -s, 0]]; 
  C("black",.5)
  {
    if(z) Tz(z) polyhedron(p, [[0,1,2,3]]); 
    if(x) Tx(x) Ry(90)polyhedron(p, [[0,1,2,3]]); 
    if(y) Ty(y) Rx(90) polyhedron(p, [[0,1,2,3]]); 
  }
}
