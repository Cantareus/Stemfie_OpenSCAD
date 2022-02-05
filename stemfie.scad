// LibFile: stemfie.scad 
//   Author: Brendon Collecutt  
//   .
//   Contact: 1976016983@qq.com
//   .
//   This file is part of Stemfie_OpenSCAD.
//   .
//   Stemfie_OpenSCAD is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//   .
//   Stemfie_OpenSCAD is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//   .
//   You should have received a copy of the GNU General Public License along with Stemfie_OpenSCAD. If not, see <https://www.gnu.org/licenses/>.
//   .
//   Please check https://stemfie.org/license.html for more information or before using stemfie commercially.  
//   .
//   OpenSCAD script for creating Stemife.org parts.  
//   .
//   Feel free to adapt and improve and share your OpenSCAD script (please contact Paulo Kiefe)  
//   .
//   Contact: paulo.kiefe@stemfie.org (https://stemfie.org)
// Includes:
//   include <stemfie.scad>


// Section: Universal constants

// Constant: BU
// Description: Universal voxel block unit (mm) in Stemfie (BlockUnit)
BU = 12.5;

// Constant: HoleRadius
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

// Section: Stemfie Parts
// Subsection: Beams

// Module: beam_block()
// Usage: 
//   beam_block(size, holes);
// Description:
//   Creates a Stemfie beam with holes.
// Arguments:
//   size = Size of block to create in block units.
//   holes = Array of booleans in xyz order for which directions to create holes or a single boolean for all directions.
// Example(3D): Standard Stemfie beam
//   beam_block(3);
// Example(3D): Stemfie beam with vertical holes only.
//   beam_block(3, holes = [false, false, true]);
// Example(3D): Stemfie 3D "beam"
//   beam_block([3, 2, 2]);
module beam_block(size = [4,1,1], holes = [true, true, true])
{
    size = is_list(size)?size:[size,1, 1];
    holes = is_list(holes)?holes:[holes,holes,holes];
    
    faceRotate = [[0,90,0],[90,0,0],[0,0,90]];
    T((size - [1,1,1]) * BU / 2)
    D()
    {
        U()
        {

            D()
            {
                BU_cube(size);
                    Tz(size.z * BU / 2)
                    bevel(offs = -Chamfer * 2 - BevelWidth, neg = true)
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

// Module: beam_cross()
// Usage: 
//   beam_cross(lengths);
// Description:
//   Overlaps two Stemfie beams. It can be used to create 'V', 'L', 'T' and 'X' shapes.
// Arguments:
//   lengths = Array of 2, 3 or 4 integers. Lengths extending from intersection block with clockwise ordering.
// Example(3D): 'V' beam
//   beam_cross([3,3]);
// Example(3D): 'L' beam
//   beam_cross([5,3]);
// Example(3D): 'T' beam
//   beam_cross([2,3,2]);
// Example(3D): 'X' beam
//   beam_cross([2,2,2,2]);
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

// Subsection: Braces
// Module: brace()
// Usage: 
//   brace(size, <h=>, <holes=>);
// Description:
//   Creates a Stemfie brace with holes.
// Arguments:
//   size = Length of brace to create in block units.
//   h = height of brace
//   holes = Set to false to create blank brace.
// Example(3D): Standard Stemfie brace
//   brace(3);
// Example(3D): Double thickness blank brace
//   brace(3, h = 0.5, holes = false);
module brace(size, h = 0.25, holes = true)
{
    BU_Tx((size-1)/2)
    D()
    {
        U()
        {
            bevel_plate(h)BU_slot(size);
            if(holes)
            hole_grid([size,1],h,false);
        }
        if(holes)
        hole_grid([size,1],h,true);
    }
    
}

// Module: brace_cross()
// Usage: 
//   brace_cross(lengths, <h>);
// Description:
//   Overlaps two Stemfie brace. It can be used to create 'V', 'L', 'T' and 'X' shapes.
// Arguments:
//   lengths = Array of 2, 3 or 4 integers. Lengths extending from intersection block with clockwise ordering.
//   h = Height of brace, default = 0.25BU
// Example(3D): 'V' brace
//   brace_cross([3,3]);
// Example(3D): 'L' brace
//   brace_cross([5,3]);
// Example(3D): 'T' brace
//   brace_cross([2,3,2]);
// Example(3D): Double thickness 'X' brace
//   brace_cross([1, 1, 1, 1], 0.5);
module brace_cross(lengths = [2,2,2,2], h = 0.25)
{
    cross_helper(len(lengths))
    {
        brace(lengths[0] + 1, h);
        if(len(lengths) > 1)
            brace(lengths[1] + 1, h);
        if(len(lengths) > 2)
            brace(lengths[2] + 1, h);
        if(len(lengths) > 3)
            brace(lengths[3] + 1, h);
    }
}

// Section: Helper Modules
// Subsection: General

// Module: hole()
// Usage:
//   hole(l, neg);
// Description:
//   Create a circular standard sized hole with beveled top and bottom.
// Arguments:
//   l = The length of the hole in base units.
//   neg = true to create hole cavity, false to create sleeve and bevel.
// Example(3D):
//   difference()
//   {
//     BU_cube();
//     hole(l = 1, neg = true);
//   }
// Example(3D):
//   hole(l = 1, neg = false);
// Example(3D):
//   difference()
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
// Example(3D): Create a brace with a slot down most of the length.
//   difference()
//   {
//     union()
//     {
//       brace(4, holes = false);
//       
//       cutout(l = 0.25, neg = false)
//         BU_Tx(1)
//           hole_slot(l = 3);
//     }
//     cutout(l = 0.25, neg = true)
//       BU_Tx(1)
//         hole_slot(l = 3);
//   }
// Example(3D): Shaft shaped hole in brace.
//   difference()
//   {
//     union()
//     {
//       brace(4, holes = false);
//         cutout(l = 0.25, neg = false)
//           offset(r=Clearance)
//             shaft_profile();
//     }
//     cutout(l = 0.25, neg = true)
//       offset(r=Clearance)
//         shaft_profile();
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
                BU_Tz(l/2)
                    bevel(0, true)
                        children();
                   
        }
    }
    else
    {
        Tz(-Chamfer / 2)
        LiEx(h = l * BU - Chamfer)
            offset(Chamfer * 2 + BevelWidth)children();
        BU_Tz(l/2)
            bevel(Chamfer * 2 + BevelWidth, false)
                children();
            
    }
}

// Module: hole_grid()
// Usage:
//   hole_grid(size, <l=1>, <neg=true>);
// Description:
//   Creates a rectangular array of holes centered on the origin with block unit spacing.
// Arguments:
//   size = List with number of holes in X and Y directions.
//   l = See {{hole()}}
//   neg = See {{hole()}}
// Example(3D): Create a 4x5 block with vertical holes.
//   difference()
//   {
//     BU_cube([4,5,1]);
//     hole_grid([4,5]);
//   }
// Example(3D): Create a 4x5x0.25 block unit plate with holes.
//   difference()
//   {
//     union()
//     {
//       bevel_plate(h = 0.25)
//         offset(r = BU/2)
//           square([3 * BU, 4 * BU], center = true);
//       hole_grid([4,5], l = 0.25, neg = false);
//     }
//     hole_grid([4,5], l = 0.25);
//   }
module hole_grid(size = [1,1], l = 1, neg = true)
{
    forXY(N = size.x, M = size.y, dx = BU, dy = BU)
        hole(l = l, neg = neg);
}

// Module: hole_list()
// Usage:
//   hole_list(list, <l=1>, <neg=true>);
// Description:
//   Creates a rectangular array of holes centered on the origin with block unit spacing.
// Arguments:
//   list = List with location of holes by X,Y co-ordinates in block units.
//   l = See {{hole()}}
//   neg = See {{hole()}}
// Example(3D): Create brace with custom hole locations
//   difference()
//   {
//     union()
//     {
//       brace(5, holes = false);
//       hole_list([[0,0],[4,0]], l = 0.25, neg = false);
//     }
//     hole_list([[0,0],[4,0]], l = 0.25);
//   }
module hole_list(list = [[0,0]], l = 1, neg = true)
{
    for(i = list)
        BU_T(i.x, i.y, 0)
            hole(l = l, neg = neg);
}


// Module: hole_slot()
// Usage:
//   hole_slot(l);
// Description:
//   Create a 2D slot profile with radius equal to {{HoleRadius}} and length l.
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
//   slot(2, r = 2 + Clearance);
module slot(l, r = BU/2)
{
    hull()
    {
        MKx()
            BU_Tx(l / 2 - 1 / 2)
                Ci(r = r);
    }
}

// Module: bevel
// Usage:
//   bevel(offs = 0, neg = true);
// Description:
//   Creates a bevel from a convex 2D profile using {{Chamfer}}.
// Figure(3D): Calling bevel() on a concave shape results in a convex bevel.
//   difference()
//   {
//       linear_extrude(0.25 * BU, center = true, convexity = 4)
//       {
//           BU_slot(3);
//           rotate([0, 0, 90])
//             BU_slot(3);
//       }
//       Tz(0.25 / 2 * BU)
//       #bevel(offs = -Chamfer - BevelWidth)
//       {
//         BU_slot(3);
//         rotate([0, 0, 90])
//           BU_slot(3);
//       }
//   }
// Figure(3D): Instead break shape into convex shapes call bevel on each shape.
//   difference()
//   {
//       linear_extrude(0.25 * BU, center = true, convexity = 4)
//       {
//           BU_slot(3);
//           rotate([0, 0, 90])
//             BU_slot(3);
//       }
//       #Tz(0.25 / 2 * BU)
//       {
//         bevel(offs = -Chamfer - BevelWidth)
//           BU_slot(3);
//         bevel(offs = -Chamfer - BevelWidth)
//           rotate([0, 0, 90])
//             BU_slot(3);
//       }
//   }
//Example(3D):
//bevel(neg = true)
//  circle(r = HoleRadius);
module bevel(offs = 0, neg = true)
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
            bevel(-Chamfer * 2 - BevelWidth, true)children();

    }
}

module cross_helper(num = 4)
{
    for(i = [0: min(3, num - 1)])
    {
        Rz(-90 * i)
        D()
        {
            children(i);
            if(num > 1)
            {
                if(num != 2 || i != 1)
                    Rz(num == 3 && i == 2?0:45)BU_Tx(-1)Cu(BU * 2);
                if(num != 2 || i != 0)
                    Rz(num == 3 && i == 0?0:-45)BU_Tx(-1)Cu(BU * 2);
            }
        }
    }

}
// Subsection: Shafts

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
//   Creates a stemfie 2D profile for creating shafts and screw heads.
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
        BU_Tx(1/2)
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

// Subsection: Braces
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

module brace_arc(r, angle, h = 0.25, holes = 2)
{
    //If the remaining angle leaves a distance less than 1BU increase the angle to 360.
    angle = ((1 - min(angle, 360)/360) * r * PI * 2 < 1)?360:min(angle, 360);
    
    //Reduce the number of holes if necessary to ensure spacing is always greater than 1BU.
    holes = min(floor(angle/180 * PI * r) + 1, holes);
    D()
    {
        U()
        {
            if(angle < 360)
            for(i=[0, 1])
            {
                Rz(i * angle)
                BU_Tx(r)
                Rz(i * 180)
                I()
                {
                    bevel_plate(h = h)
                        Ci(BU/2);
                    BU_Ty(-1/2)
                        Cu(BU+1, BU, BU * h + 1);
                }
            }
            
            if(holes > 0)
                for(n = [0:holes - 1])
                    Rz(n * angle / (holes-(angle == 360?0:1)))
                        BU_Tx(r)
                        hole(l = 0.25, neg = false);
            
            rotate_extrude(angle=angle, convexity = 8, $fn = FragmentNumber * r * 2)
               BU_Tx(r)
                 brace_cross_section(h = h);
        }
        
        if(holes > 0)
                for(n = [0:holes - 1])
                    Rz(n * angle / (holes-(angle == 360?0:1)))
                        BU_Tx(r)
                        hole(l = 0.25, neg = true);
        
        
    }

            
}


// Subsection: Beams

// Module: BU_cube()
// Usage:
//   BU_cube(size = [1,1,1]);
// Description:
//   Create a beveled cube of given size in block units.
// Arguments:
//   BU_cube = Size of cube
// Example(3D):
//   BU_cube();
// Example(3D):
//   BU_cube([3,1,1]);
module BU_cube(size = [1,1,1])
{
    D()
    {
        hull()
            for(i = [[0, 1, 1],[1, 0, 1],[1, 1, 0]])
                Cu(size * BU - i * Chamfer*2);
    }
}

// Subsection: Block Unit Translation Shortcuts
//   Modified from Rudolf Huttary's [shortcuts.scad](https://www.thingiverse.com/thing:644830)

// Module: BU_T();
// Usage:
//   BU_T(x, y, z);
//   BU_T([x, y, z]);
// Description:
//   Shortcut for translate([x * BU, y * BU, z * BU])
module BU_T(x=0, y=0, z=0){
  translate(x[0]==undef?[x, y, z]* BU:x * BU)children(); }

// Module: BU_TK()
// Usage:
//   BU_TK(x, y, z);
//   BU_TK([x, y, z]);
// Description:
//   Children at origin and translation.
// Example(3D): One block unit cube centered at origin and one at [3 * BU, 0, 0]
//   BU_TK(3, 0 , 0) BU_cube();
module BU_TK(x=0, y=0, z=0){ children(); BU_T(x, y, z) children(); }

// Module: BU_Tx()
// Usage: BU_Tx(x)
// Description:
//   Shortcut for translate([x * BU, 0, 0])
module BU_Tx(x) { translate([x * BU, 0, 0])children(); }

// Module: BU_Ty()
// Usage: BU_Ty(y)
// Description:
//   Shortcut for translate([0, y * BU, 0])
module BU_Ty(y) { translate([0, y * BU, 0])children(); }

// Module: BU_Tz()
// Usage: BU_Tz(z)
// Description:
//   Shortcut for translate([0, 0, z * BU])
module BU_Tz(z) { translate([0, 0, z * BU])children(); }

// Module: BU_TKx()
// Usage: BU_TKx(x)
// Description:
//   Alternative for BU_TK(x=x)
module BU_TKx(x) { BU_TK(x=x) children(); }

// Module: BU_TKy()
// Usage: BU_TKy(z)
// Description:
//   Alternative for BU_TK(y=y)
module BU_TKy(y) { BU_TK(y=y) children(); }

// Module: BU_TKz()
// Usage: BU_TKz(z)
// Description:
//   Alternative for BU_TK(z=z)
module BU_TKz(z) { BU_TK(z=z) children(); }


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
