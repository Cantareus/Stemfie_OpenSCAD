# LibFile: stemfie.scad


To use, add the following lines to the beginning of your file:

    include <stemfie.scad>

## Table of Contents

- [`BU`](#constant-bu)
- [`FragmentNumber`](#constant-fragmentnumber)
- [`Chamfer`](#constant-chamfer)
- [`BevelWidth`](#constant-bevelwidth)
- [`Clearance`](#constant-clearance)
- [`ShaftRadius`](#constant-shaftradius)
- [`ShaftFlat`](#constant-shaftflat)
- [`shaft_profile()`](#module-shaft_profile)
- [`shaft_head_profile()`](#module-shaft_head_profile)
- [`shaft_head()`](#module-shaft_head)
- [`shaft()`](#module-shaft)
- [`shaft_with_hole()`](#module-shaft_with_hole)
- [`hole()`](#module-hole)
- [`cutout()`](#module-cutout)
- [`hole_slot()`](#module-hole_slot)
- [`BU_slot()`](#module-bu_slot)
- [`slot()`](#module-slot)


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

Creats a stemfie 2D profile for creating shafts and screw heads.

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

### Module: shaft\_with\_hole()

**Usage:** 

- shaft\_with\_hole(l, d)

**Description:** 

Stemfie blank shaft for creating shafts and screws.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`l`                  | Length of shaft.
`d`                  | Diameter of hole through shaft.
`beveled_ends`       | Bevel ends of shaft using the global [`Chamfer`](#constant-chamfer) setting.

<br/>

**Example 1:** 

<img align="left" alt="shaft\_with\_hole() Example 1" src="images\stemfie\shaft_with_hole.png" width="320" height="240">

    include <stemfie.scad>
    shaft_with_hole(4);

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="shaft\_with\_hole() Example 2" src="images\stemfie\shaft_with_hole_2.png" width="320" height="240">

    include <stemfie.scad>
    shaft_with_hole(4, 1.2, false);

<br clear="all" />

---

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
    D()
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
    D()
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

**Example 1:** 

<img align="left" alt="cutout() Example 1" src="images\stemfie\cutout.png" width="320" height="240">

    include <stemfie.scad>
    cutout(l = 2, neg = true)
      slot(l = 3);

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="cutout() Example 2" src="images\stemfie\cutout_2.png" width="320" height="240">

    include <stemfie.scad>
    cutout(l = 2, neg = false);
      slot(l = 3);

<br clear="all" />

<br/>

**Example 3:** Square hole

<img align="left" alt="cutout() Example 3" src="images\stemfie\cutout_3.png" width="320" height="240">

    include <stemfie.scad>
    D()
    {
      cutout(l = 2, neg = false)
        square(HoleRadius * 2, center = true);
      cutout(l = 2, neg = true)
        square(HoleRadius * 2, center = true);
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

