# LibFile: stemfie.scad


To use, add the following lines to the beginning of your file:

    include <stemfie.scad>

## Table of Contents

1. [Section: Universal constants](#section-universal-constants)
    - [`BU`](#constant-bu)
    - [`FragmentNumber`](#constant-fragmentnumber)
    - [`Chamfer`](#constant-chamfer)
    - [`BevelWidth`](#constant-bevelwidth)
    - [`Clearance`](#constant-clearance)
    - [`ShaftRadius`](#constant-shaftradius)
    - [`ShaftFlat`](#constant-shaftflat)

2. [Section: Stemfie Parts](#section-stemfie-parts)
    1. [Subsection: Beams](#subsection-beams)
    2. [Subsection: Braces](#subsection-braces)
    
    - [`beam_block()`](#module-beam_block)
    - [`beam_cross()`](#module-beam_cross)
    - [`brace()`](#module-brace)
    - [`brace_cross()`](#module-brace_cross)

3. [Section: Helper Modules](#section-helper-modules)
    1. [Subsection: General](#subsection-general)
    2. [Subsection: Shafts](#subsection-shafts)
    3. [Subsection: Braces](#subsection-braces)
    4. [Subsection: Beams](#subsection-beams)
    
    - [`hole()`](#module-hole)
    - [`cutout()`](#module-cutout)
    - [`hole_grid()`](#module-hole_grid)
    - [`hole_slot()`](#module-hole_slot)
    - [`BU_slot()`](#module-bu_slot)
    - [`slot()`](#module-slot)
    - [`shaft_profile()`](#module-shaft_profile)
    - [`shaft_head_profile()`](#module-shaft_head_profile)
    - [`shaft_head()`](#module-shaft_head)
    - [`shaft()`](#module-shaft)


## Section: Universal constants


### Constant: BU

**Description:** 

Universal voxel block unit (mm) in Stemfie (BlockUnit)

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

### Constant: ShaftFlat

**Description:** 

Universal distance (mm) between two flat sides of the connection shaft.

---

## Section: Stemfie Parts


## Subsection: Beams


### Module: beam\_block()

**Usage:** 

- beam\_block(size, holes);

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
    beam_block(3, holes = [false, false, true]);

<br clear="all" />

<br/>

**Example 3:** Stemfie 3D "beam"

<img align="left" alt="beam\_block() Example 3" src="images\stemfie\beam_block_3.png" width="320" height="240">

    include <stemfie.scad>
    beam_block([3, 2, 2]);

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

## Section: Helper Modules


## Subsection: General


### Module: hole()

**Usage:** 

- hole(l, neg);

**Description:** 

Create a circular standard sized hole with beveled top and bottom.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | The length of the hole in base units.
`neg`                | true to create hole cavity, false to create sleeve and bevel.

<br/>

**Example 1:** 

<img align="left" alt="hole() Example 1" src="images\stemfie\hole.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      BU_cube();
      hole(l = 1, neg = true);
    }

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="hole() Example 2" src="images\stemfie\hole_2.png" width="320" height="240">

    include <stemfie.scad>
    hole(l = 1, neg = false);

<br clear="all" />

<br/>

**Example 3:** 

<img align="left" alt="hole() Example 3" src="images\stemfie\hole_3.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      hole(l = 1, neg = false);
      hole(l = 1, neg = true);
    }

<br clear="all" />

---

### Module: cutout()

**Usage:** 

- cutout(l, neg);

**Description:** 

Create an irregular sized hole with beveled top and bottom. Children should be a convex 2D shape.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | The length of the cutout in base units.
`neg`                | true to create cutout cavity, false to create sleeve and top bevel.

<br/>

**Example 1:** Create a brace with a slot down most of the length.

<img align="left" alt="cutout() Example 1" src="images\stemfie\cutout.png" width="320" height="240">

    include <stemfie.scad>
    difference()
    {
      union()
      {
        brace(4, holes = false);
    
        cutout(l = 0.25, neg = false)
          Tx(BU)
          hole_slot(l = 3);
      }
      cutout(l = 0.25, neg = true)
      Tx(BU)
      hole_slot(l = 3);
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
          cutout(l = 0.25, neg = false)
            offset(r=Clearance)
              shaft_profile();
      }
      cutout(l = 0.25, neg = true)
        offset(r=Clearance)
          shaft_profile();
    }

<br clear="all" />

---

### Module: hole\_grid()

**Usage:** 

- hole\_grid(size, &lt;l=&gt;, &lt;neg=&gt;);

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

### Module: hole\_slot()

**Usage:** 

- hole\_slot(l);

**Description:** 

Create a 2D slot profile with radius HoleRadius

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

- BU\_slot(l);

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

- slot(l, r);

**Description:** 

Create a 2D slot profile.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | Length of slot in block units.

<br/>

**Example 1:** 

<img align="left" alt="slot() Example 1" src="images\stemfie\slot.png" width="320" height="240">

    include <stemfie.scad>
    slot(2);

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

### Module: shaft\_head\_profile()

**Usage:** 

- shaft\_head\_profile()

**Description:** 

Creates a stemfie 2D profile for creating shafts and screw heads.

<br/>

**Example 1:** 

<img align="left" alt="shaft\_head\_profile() Example 1" src="images\stemfie\shaft_head_profile.png" width="320" height="240">

    include <stemfie.scad>
    shaft_head_profile();

<br clear="all" />

---

### Module: shaft\_head()

**Usage:** 

- shaft\_head()

**Description:** 

Creats a stemfie shaft or screw head for creating shafts and screws.

<br/>

**Example 1:** 

<img align="left" alt="shaft\_head() Example 1" src="images\stemfie\shaft_head.png" width="320" height="240">

    include <stemfie.scad>
    shaft_head();

<br clear="all" />

---

### Module: shaft()

**Usage:** 

- shaft(l, beveled\_ends)

**Description:** 

Creates a stemfie blank shaft for creating shafts and screws.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | The length of the shaft in base units.
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

## Subsection: Braces


## Subsection: Beams


