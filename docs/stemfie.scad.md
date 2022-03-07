# LibFile: stemfie.scad

Author: Brendon Collecutt

Contact: 1976016983@qq.com

This file is part of Stemfie_OpenSCAD.

Stemfie_OpenSCAD is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Stemfie_OpenSCAD is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with Stemfie_OpenSCAD. If not, see <https://www.gnu.org/licenses/>.

Please check https://stemfie.org/license for more information or before using stemfie commercially.

OpenSCAD script for creating Stemife.org parts.

Feel free to adapt and improve and share your OpenSCAD script (please contact Paulo Kiefe)

Contact: paulo.kiefe@stemfie.org (https://stemfie.org)

To use, add the following lines to the beginning of your file:

    include <stemfie.scad>

## Table of Contents

1. [Section: Universal constants](#section-universal-constants)
    - [`BU`](#constant-bu)
    - [`HoleRadius`](#constant-holeradius)
    - [`FragmentNumber`](#constant-fragmentnumber)
    - [`Chamfer`](#constant-chamfer)
    - [`BevelWidth`](#constant-bevelwidth)
    - [`Clearance`](#constant-clearance)
    - [`ShaftRadius`](#constant-shaftradius)
    - [`PinRadius`](#constant-pinradius)
    - [`ShaftFlat`](#constant-shaftflat)
    - [`FastenerFlat`](#constant-fastenerflat)
    - [`ThreadPitch`](#constant-threadpitch)

2. [Section: Stemfie Parts](#section-stemfie-parts)
    1. [Subsection: Beams](#subsection-beams)
    2. [Subsection: Braces](#subsection-braces)
    3. [Subsection: Fasteners](#subsection-fasteners)
    4. [Subsection: Washers and Spacers](#subsection-washers-and-spacers)
    
    - [`beam_block()`](#module-beam_block)
    - [`beam_threaded()`](#module-beam_threaded)
    - [`beam_cross()`](#module-beam_cross)
    - [`brace()`](#module-brace)
    - [`brace_cross()`](#module-brace_cross)
    - [`brace_arc()`](#module-brace_arc)
    - [`screw()`](#module-screw)
    - [`pin`](#module-pin)
    - [`nut()`](#module-nut)
    - [`spacer()`](#module-spacer)
    - [`fixed_washer()`](#module-fixed_washer)

3. [Section: Helper Modules](#section-helper-modules)
    1. [Subsection: General](#subsection-general)
    2. [Subsection: Shafts](#subsection-shafts)
    3. [Subsection: Nuts and Washers](#subsection-nuts-and-washers)
    4. [Subsection: Braces](#subsection-braces)
    5. [Subsection: Beams](#subsection-beams)
    6. [Subsection: Block Unit Translation Shortcuts](#subsection-block-unit-translation-shortcuts)
    
    - [`hole()`](#module-hole)
    - [`cutout()`](#module-cutout)
    - [`hole_grid()`](#module-hole_grid)
    - [`hole_list()`](#module-hole_list)
    - [`hole_slot()`](#module-hole_slot)
    - [`BU_slot()`](#module-bu_slot)
    - [`slot()`](#module-slot)
    - [`thread()`](#module-thread)
    - [`bevel`](#module-bevel)
    - [`shaft_profile()`](#module-shaft_profile)
    - [`fastener_profile()`](#module-fastener_profile)
    - [`pin_profile()`](#module-pin_profile)
    - [`fastener_head_profile()`](#module-fastener_head_profile)
    - [`fastener_head()`](#module-fastener_head)
    - [`shaft()`](#module-shaft)
    - [`nut_blank()`](#module-nut_blank)
    - [`BU_cube()`](#module-bu_cube)
    - [`BU_T()`](#module-bu_t)
    - [`BU_TK()`](#module-bu_tk)
    - [`BU_Tx()`](#module-bu_tx)
    - [`BU_Ty()`](#module-bu_ty)
    - [`BU_Tz()`](#module-bu_tz)
    - [`BU_TKx()`](#module-bu_tkx)
    - [`BU_TKy()`](#module-bu_tky)
    - [`BU_TKz()`](#module-bu_tkz)


## Section: Universal constants


### Constant: BU

**Description:** 

Universal voxel block unit (mm) in Stemfie (BlockUnit)

---

### Constant: HoleRadius

**Description:** 

Universal radius (mm) of the connection hole

---

### Constant: FragmentNumber

**Description:** 

Universal tesselation value of curved surfaces

---

### Constant: Chamfer

**Description:** 

Chamfer size adjustment value for all edges

---

### Constant: BevelWidth

**Description:** 

Width of the top section of beveled edges. Must be less or equal to
twice printer nozzle diameter to ensure level top surface.

---

### Constant: Clearance

**Description:** 

Distance between hole and shafts and
other parts that need to move relatively to each other.

---

### Constant: ShaftRadius

**Description:** 

Universal radius (mm) of the connection shaft

---

### Constant: PinRadius

**Description:** 

Universal radius (mm) of the connection pin

---

### Constant: ShaftFlat

**Description:** 

Universal distance (mm) between two flat sides of the shafts.

---

### Constant: FastenerFlat

**Description:** 

Universal distance (mm) between two flat sides of pin and screw fasteners.

---

### Constant: ThreadPitch

**Description:** 

Universal pitch (mm) for Stemfie threaded fasteners

---

## Section: Stemfie Parts


## Subsection: Beams


### Module: beam\_block()

**Usage:** 

- beam\_block(size, holes, center);

**Description:** 

Creates a Stemfie beam with holes.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | Size of block to create in block units.
`holes`              | Array of booleans in xyz order for which directions to create holes or a single boolean for all directions.

<br/>

**Example 1:** Standard Stemfie beam

<img align="left" alt="beam\_block() Example 1" src="images\stemfie\beam_block.png" width="320" height="240">

    include <stemfie.scad>
    beam_block(3);

<br clear="all" />

<br/>

**Example 2:** Stemfie beam with vertical holes only.

<img align="left" alt="beam\_block() Example 2" src="images\stemfie\beam_block_2.png" width="320" height="240">

    include <stemfie.scad>
    beam_block(3, holes = [false, false, true], center = false);

<br clear="all" />

<br/>

**Example 3:** Stemfie 3D "beam"

<img align="left" alt="beam\_block() Example 3" src="images\stemfie\beam_block_3.png" width="320" height="240">

    include <stemfie.scad>
    beam_block([3, 2, 2]);

<br clear="all" />

---

### Module: beam\_threaded()

**Usage:** 

- beam\_threaded(length);

**Description:** 

Creates a stemfie beam with threaded ends.

<br/>

**Example 1:** 

<img align="left" alt="beam\_threaded() Example 1" src="images\stemfie\beam_threaded.png" width="320" height="240">

    include <stemfie.scad>
    beam_threaded(4);

<br clear="all" />

---

### Module: beam\_cross()

**Usage:** 

- beam\_cross(lengths);

**Description:** 

Overlaps two Stemfie beams. It can be used to create 'V', 'L', 'T' and 'X' shapes.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`lengths`            | Array of 2, 3 or 4 integers. Lengths extending from intersection block with clockwise ordering.

<br/>

**Example 1:** 'V' beam

<img align="left" alt="beam\_cross() Example 1" src="images\stemfie\beam_cross.png" width="320" height="240">

    include <stemfie.scad>
    beam_cross([3,3]);

<br clear="all" />

<br/>

**Example 2:** 'L' beam

<img align="left" alt="beam\_cross() Example 2" src="images\stemfie\beam_cross_2.png" width="320" height="240">

    include <stemfie.scad>
    beam_cross([5,3]);

<br clear="all" />

<br/>

**Example 3:** 'T' beam

<img align="left" alt="beam\_cross() Example 3" src="images\stemfie\beam_cross_3.png" width="320" height="240">

    include <stemfie.scad>
    beam_cross([2,3,2]);

<br clear="all" />

<br/>

**Example 4:** 'X' beam

<img align="left" alt="beam\_cross() Example 4" src="images\stemfie\beam_cross_4.png" width="320" height="240">

    include <stemfie.scad>
    beam_cross([2,2,2,2]);

<br clear="all" />

---

## Subsection: Braces


### Module: brace()

**Usage:** 

- brace(size, &lt;h=&gt;, &lt;holes=&gt;);

**Description:** 

Creates a Stemfie brace with holes.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | Length of brace to create in block units.
`h`                  | height of brace
`holes`              | Set to false to create blank brace.

<br/>

**Example 1:** Standard Stemfie brace

<img align="left" alt="brace() Example 1" src="images\stemfie\brace.png" width="320" height="240">

    include <stemfie.scad>
    brace(3);

<br clear="all" />

<br/>

**Example 2:** Double thickness blank brace

<img align="left" alt="brace() Example 2" src="images\stemfie\brace_2.png" width="320" height="240">

    include <stemfie.scad>
    brace(3, h = 0.5, holes = false);

<br clear="all" />

---

### Module: brace\_cross()

**Usage:** 

- brace\_cross(lengths, &lt;h&gt;);

**Description:** 

Overlaps two Stemfie brace. It can be used to create 'V', 'L', 'T' and 'X' shapes.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`lengths`            | Array of 2, 3 or 4 integers. Lengths extending from intersection block with clockwise ordering.
`h`                  | Height of brace, default = 0.25BU

<br/>

**Example 1:** 'V' brace

<img align="left" alt="brace\_cross() Example 1" src="images\stemfie\brace_cross.png" width="320" height="240">

    include <stemfie.scad>
    brace_cross([3,3]);

<br clear="all" />

<br/>

**Example 2:** 'L' brace

<img align="left" alt="brace\_cross() Example 2" src="images\stemfie\brace_cross_2.png" width="320" height="240">

    include <stemfie.scad>
    brace_cross([5,3]);

<br clear="all" />

<br/>

**Example 3:** 'T' brace

<img align="left" alt="brace\_cross() Example 3" src="images\stemfie\brace_cross_3.png" width="320" height="240">

    include <stemfie.scad>
    brace_cross([2,3,2]);

<br clear="all" />

<br/>

**Example 4:** Double thickness 'X' brace

<img align="left" alt="brace\_cross() Example 4" src="images\stemfie\brace_cross_4.png" width="320" height="240">

    include <stemfie.scad>
    brace_cross([1, 1, 1, 1], 0.5);

<br clear="all" />

---

### Module: brace\_arc()

**Usage:** 

- brace\_arc(r, angle, h = 0.25, holes = 2);

**Description:** 

Creates a circular arc brace. Detects when hole spacing is less than
1 block unit and reduces the number of holes as necessary. If the angle is
too big and the end point overlaps the start point then the angle is set to 360
and a circular brace is created.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | Radius in block units to the center of the brace.
`angle`              | Angle between start and end points.

<br/>

**Example 1:** Holes with 60 degree spacing have 1 radius spacing.

<img align="left" alt="brace\_arc() Example 1" src="images\stemfie\brace_arc.png" width="320" height="240">

    include <stemfie.scad>
    brace_arc(2, 120, holes = 3);

<br clear="all" />

<br/>

**Example 2:** Number of holes are reduced to fit of brace.

<img align="left" alt="brace\_arc() Example 2" src="images\stemfie\brace_arc_2.png" width="320" height="240">

    include <stemfie.scad>
    brace_arc(3, 360, holes = 100);

<br clear="all" />

<br/>

**Example 3:** Angle adjusted to 360 to prevent overlap.

<img align="left" alt="brace\_arc() Example 3" src="images\stemfie\brace_arc_3.png" width="320" height="240">

    include <stemfie.scad>
    brace_arc(3, 350, holes = 12);

<br clear="all" />

---

## Subsection: Fasteners


### Module: screw()

**Usage:** 

- screw(thread\_length, shaft\_length = 0.125, screw\_head = true);

**Description:** 

Creates a stemfie screw.

<br/>

**Example 1:** Add 0.125 BU of unthreaded shaft to get that standard look.

<img align="left" alt="screw() Example 1" src="images\stemfie\screw.png" width="320" height="240">

    include <stemfie.scad>
    screw(1.375, 0.125);

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="screw() Example 2" src="images\stemfie\screw_2.png" width="320" height="240">

    include <stemfie.scad>
    screw(0.5, 3);

<br clear="all" />

<br/>

**Example 3:** 

<img align="left" alt="screw() Example 3" src="images\stemfie\screw_3.png" width="320" height="240">

    include <stemfie.scad>
    screw(1.5, screw_head = false);

<br clear="all" />

---

### Module: pin

**Usage:** 

- pin(length, head = true);

**Description:** 

Creates an almost standard stemfie pin.

<br/>

**Example 1:** 

<img align="left" alt="pin Example 1" src="images\stemfie\pin.png" width="320" height="240">

    include <stemfie.scad>
    pin(length = 1, head = true);

<br clear="all" />

---

### Module: nut()

**Usage:** 

- nut\_open(length = 5/BU, center = true);

**Description:** 

Creates a threaded open nut.

<br/>

**Example 1:** Standard 5mm open nut

<img align="left" alt="nut() Example 1" src="images\stemfie\nut.png" width="320" height="240">

    include <stemfie.scad>
    nut_open();

<br clear="all" />

<br/>

**Example 2:** 1 block unit threaded nut.

<img align="left" alt="nut() Example 2" src="images\stemfie\nut_2.png" width="320" height="240">

    include <stemfie.scad>
    nut_open(1);

<br clear="all" />

---

## Subsection: Washers and Spacers


### Module: spacer()

**Usage:** 

- module spacer(length = 0.25, center = true);

**Description:** 

Creates a free spacer to fit over a shaft or fastener.

<br/>

**Example 1:** 

<img align="left" alt="spacer() Example 1" src="images\stemfie\spacer.png" width="320" height="240">

    include <stemfie.scad>
    spacer(length = 0.5, center = false);

<br clear="all" />

---

### Module: fixed\_washer()

**Usage:** 

- fixed\_washer(length = 0.25, center = true);

**Description:** 

Creates a fixed washer to fit a fastener.

<br/>

**Example 1:** Standard 0.25 block unit fixed washer

<img align="left" alt="fixed\_washer() Example 1" src="images\stemfie\fixed_washer.png" width="320" height="240">

    include <stemfie.scad>
    fixed_washer();

<br clear="all" />

<br/>

**Example 2:** 10mm fixed washer

<img align="left" alt="fixed\_washer() Example 2" src="images\stemfie\fixed_washer_2.png" width="320" height="240">

    include <stemfie.scad>
    fixed_washer(10 / BU);

<br clear="all" />

---

## Section: Helper Modules


## Subsection: General


### Module: hole()

**Usage:** 

- hole(depth = 1, neg = true, bevel = [true,true]);

**Description:** 

Create a circular standard sized hole with beveled top and bottom.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`depth`              | The depth of the hole in base units.
`neg`                | true to create hole cavity, false to create sleeve and bevel.
`bevel`              | [bevel on top, bevel on bottom]

<br/>

**Example 1:** 

<img align="left" alt="hole() Example 1" src="images\stemfie\hole.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      BU_cube();
      hole(depth = 1, neg = true);
    }

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="hole() Example 2" src="images\stemfie\hole_2.png" width="320" height="240">

    include <stemfie.scad>
    hole(depth = 1, neg = false);

<br clear="all" />

<br/>

**Example 3:** 

<img align="left" alt="hole() Example 3" src="images\stemfie\hole_3.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      hole(depth = 1, neg = false);
      hole(depth = 1, neg = true);
    }

<br clear="all" />

---

### Module: cutout()

**Usage:** 

- cutout(depth, neg = true, bevel = [true,true]);

**Description:** 

Create an irregular sized hole with beveled top and bottom. Children should be a convex 2D shape.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`depth`              | The depth of the cutout in base units.
`neg`                | true to create cutout cavity, false to create sleeve and top bevel.
`bevel`              | [bevel on top, bevel on bottom]

<br/>

**Example 1:** Create a brace with a slot down most of the length.

<img align="left" alt="cutout() Example 1" src="images\stemfie\cutout.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      union()
      {
        brace(4, holes = false);
    
        cutout(depth = 0.25, neg = false)
          BU_Tx(1)
            hole_slot(length = 3);
      }
      cutout(depth = 0.25, neg = true)
        BU_Tx(1)
          hole_slot(length = 3);
    }

<br clear="all" />

<br/>

**Example 2:** Shaft shaped hole in brace.

<img align="left" alt="cutout() Example 2" src="images\stemfie\cutout_2.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      union()
      {
        brace(4, holes = false);
          cutout(depth = 0.25, neg = false)
            offset(r=Clearance)
              shaft_profile();
      }
      cutout(depth = 0.25, neg = true)
        offset(r=Clearance)
          shaft_profile();
    }

<br clear="all" />

---

### Module: hole\_grid()

**Usage:** 

- hole\_grid(size, &lt;l=1&gt;, &lt;neg=true&gt;);

**Description:** 

Creates a rectangular array of holes centered on the origin with block unit spacing.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | List with number of holes in X and Y directions.
`l`                  | See [`hole()`](#module-hole)
`neg`                | See [`hole()`](#module-hole)

<br/>

**Example 1:** Create a 4x5 block with vertical holes.

<img align="left" alt="hole\_grid() Example 1" src="images\stemfie\hole_grid.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      BU_cube([4,5,1]);
      hole_grid([4,5]);
    }

<br clear="all" />

<br/>

**Example 2:** Create a 4x5x0.25 block unit plate with holes.

<img align="left" alt="hole\_grid() Example 2" src="images\stemfie\hole_grid_2.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      union()
      {
        bevel_plate(h = 0.25)
          offset(r = BU/2)
            square([3 * BU, 4 * BU], center = true);
        hole_grid([4,5], l = 0.25, neg = false);
      }
      hole_grid([4,5], l = 0.25);
    }

<br clear="all" />

---

### Module: hole\_list()

**Usage:** 

- hole\_list(list, &lt;l=1&gt;, &lt;neg=true&gt;);

**Description:** 

Creates a rectangular array of holes centered on the origin with block unit spacing.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`list`               | List with location of holes by X,Y co-ordinates in block units.
`l`                  | See [`hole()`](#module-hole)
`neg`                | See [`hole()`](#module-hole)

<br/>

**Example 1:** Create brace with custom hole locations

<img align="left" alt="hole\_list() Example 1" src="images\stemfie\hole_list.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      union()
      {
        brace(5, holes = false);
        hole_list([[0,0],[4,0]], l = 0.25, neg = false);
      }
      hole_list([[0,0],[4,0]], l = 0.25);
    }

<br clear="all" />

---

### Module: hole\_slot()

**Usage:** 

- hole\_slot(length);

**Description:** 

Create a 2D slot profile with radius equal to [`HoleRadius`](#constant-holeradius) and length l.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | Length of slot in block units.

<br/>

**Example 1:** 

<img align="left" alt="hole\_slot() Example 1" src="images\stemfie\hole_slot.png" width="320" height="240">

    include <stemfie.scad>
    hole_slot(2);

<br clear="all" />

---

### Module: BU\_slot()

**Usage:** 

- BU\_slot(length);

**Description:** 

Create a 2D slot profile with radius [`BU`](#constant-bu)/2

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | Length of slot in block units.

<br/>

**Example 1:** 

<img align="left" alt="BU\_slot() Example 1" src="images\stemfie\bu_slot.png" width="320" height="240">

    include <stemfie.scad>
    BU_slot(2);

<br clear="all" />

---

### Module: slot()

**Usage:** 

- slot(length, r);

**Description:** 

Create a 2D slot profile.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`length`             | Length of slot in block units.

<br/>

**Example 1:** 

<img align="left" alt="slot() Example 1" src="images\stemfie\slot.png" width="320" height="240">

    include <stemfie.scad>
    slot(2, r = 2 + Clearance);

<br clear="all" />

---

### Module: thread()

**Usage:** 

- thread(length, internal = false, bevel = false, center = true);
- thread(length, internal = false, bevel = [false, false], center = true);

<br/>

**Example 1:** 

<img align="left" alt="thread() Example 1" src="images\stemfie\thread.png" width="320" height="240">

<br clear="all" />

    include <stemfie.scad>
    difference()
    {
       BU_cube([1,1,1]);
    
       thread(2, internal = true, center = true, bevel = [true,false]);
    }

---

### Module: bevel

**Usage:** 

- bevel(offs = 0, neg = true);

**Description:** 

Creates a bevel from a convex 2D profile using [`Chamfer`](#constant-chamfer).

<br/>

**Figure 1:** Calling bevel() on a concave shape results in a convex bevel.

<img align="left" alt="bevel Figure 1" src="images\stemfie\bevel_fig1.png" width="320" height="240">

<br clear="all" />

<br/>

**Figure 2:** Instead break shape into convex shapes call bevel on each shape.

<img align="left" alt="bevel Figure 2" src="images\stemfie\bevel_fig2.png" width="320" height="240">

<br clear="all" />

<br/>

**Example 1:** 

<img align="left" alt="bevel Example 1" src="images\stemfie\bevel.png" width="320" height="240">

    include <stemfie.scad>
    bevel(neg = false)
      circle(r = HoleRadius);

<br clear="all" />

---

## Subsection: Shafts


### Module: shaft\_profile()

**Usage:** 

- shaft\_profile();

**Description:** 

Creates a stemfie 2D profile for creating shafts and screws.

<br/>

**Example 1:** 

<img align="left" alt="shaft\_profile() Example 1" src="images\stemfie\shaft_profile.png" width="320" height="240">

    include <stemfie.scad>
    shaft_profile();

<br clear="all" />

---

### Module: fastener\_profile()

**Usage:** 

- fastener\_profile();

**Description:** 

Creates a stemfie 2D profile for creating pins and screws.

<br/>

**Example 1:** 

<img align="left" alt="fastener\_profile() Example 1" src="images\stemfie\fastener_profile.png" width="320" height="240">

    include <stemfie.scad>
    fastener_profile();

<br clear="all" />

---

### Module: pin\_profile()

**Usage:** 

- pin\_profile();

**Description:** 

Creates a stemfie 2D profile for creating pins.

<br/>

**Example 1:** 

<img align="left" alt="pin\_profile() Example 1" src="images\stemfie\pin_profile.png" width="320" height="240">

    include <stemfie.scad>
    pin_profile();

<br clear="all" />

---

### Module: fastener\_head\_profile()

**Usage:** 

- fastener\_head\_profile()

**Description:** 

Creates a stemfie 2D profile for creating shafts and screw heads.

<br/>

**Example 1:** 

<img align="left" alt="fastener\_head\_profile() Example 1" src="images\stemfie\fastener_head_profile.png" width="320" height="240">

    include <stemfie.scad>
    fastener_head_profile();

<br clear="all" />

---

### Module: fastener\_head()

**Usage:** 

- fastener\_head()

**Description:** 

Creates a stemfie fastener head for creating pins and screws.

<br/>

**Example 1:** 

<img align="left" alt="fastener\_head() Example 1" src="images\stemfie\fastener_head.png" width="320" height="240">

    include <stemfie.scad>
    fastener_head();

<br clear="all" />

---

### Module: shaft()

**Usage:** 

- shaft(length, beveled\_ends)

**Description:** 

Creates a stemfie blank shaft for creating shafts and screws.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`length`             | The length of the shaft in base units.
`beveled_ends`       | Bevel ends of shaft using the global [`Chamfer`](#constant-chamfer) setting.

<br/>

**Example 1:** Shaft with beveled ends

<img align="left" alt="shaft() Example 1" src="images\stemfie\shaft.png" width="320" height="240">

    include <stemfie.scad>
    shaft(4, true);

<br clear="all" />

<br/>

**Example 2:** Shaft without beveled ends

<img align="left" alt="shaft() Example 2" src="images\stemfie\shaft_2.png" width="320" height="240">

    include <stemfie.scad>
    shaft(4, false);

<br clear="all" />

---

## Subsection: Nuts and Washers


### Module: nut\_blank()

**Usage:** 

- nut\_blank(length = 0.25, center = true)

**Description:** 

Creates a nut template with solid interior that can be used to
create nuts and washers.

<br/>

**Example 1:** 

<img align="left" alt="nut\_blank() Example 1" src="images\stemfie\nut_blank.png" width="320" height="240">

    include <stemfie.scad>
    nut_blank(0.5);

<br clear="all" />

---

## Subsection: Braces


## Subsection: Beams


### Module: BU\_cube()

**Usage:** 

- BU\_cube(size = [1,1,1]);

**Description:** 

Create a beveled cube of given size in block units.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`BU_cube`            | Size of cube

<br/>

**Example 1:** 

<img align="left" alt="BU\_cube() Example 1" src="images\stemfie\bu_cube.png" width="320" height="240">

    include <stemfie.scad>
    BU_cube();

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="BU\_cube() Example 2" src="images\stemfie\bu_cube_2.png" width="320" height="240">

    include <stemfie.scad>
    BU_cube([3,1,1]);

<br clear="all" />

---

## Subsection: Block Unit Translation Shortcuts

Modified from Rudolf Huttary's [shortcuts.scad](https://www.thingiverse.com/thing:644830)

### Module: BU\_T()

**Usage:** 

- BU\_T(x, y, z);
- BU\_T([x, y, z]);

**Description:** 

Shortcut for translate([x * BU, y * BU, z * BU])

---

### Module: BU\_TK()

**Usage:** 

- BU\_TK(x, y, z);
- BU\_TK([x, y, z]);

**Description:** 

Children at origin and translation.

<br/>

**Example 1:** One block unit cube centered at origin and one at [3 * BU, 0, 0]

<img align="left" alt="BU\_TK() Example 1" src="images\stemfie\bu_tk.png" width="320" height="240">

    include <stemfie.scad>
    BU_TK(3, 0 , 0) BU_cube();

<br clear="all" />

---

### Module: BU\_Tx()

**Usage:** BU\\_Tx(x)


**Description:** 

Shortcut for translate([x * BU, 0, 0])

---

### Module: BU\_Ty()

**Usage:** BU\\_Ty(y)


**Description:** 

Shortcut for translate([0, y * BU, 0])

---

### Module: BU\_Tz()

**Usage:** BU\\_Tz(z)


**Description:** 

Shortcut for translate([0, 0, z * BU])

---

### Module: BU\_TKx()

**Usage:** BU\\_TKx(x)


**Description:** 

Alternative for BU_TK(x=x)

---

### Module: BU\_TKy()

**Usage:** BU\\_TKy(z)


**Description:** 

Alternative for BU_TK(y=y)

---

### Module: BU\_TKz()

**Usage:** BU\\_TKz(z)


**Description:** 

Alternative for BU_TK(z=z)

---

