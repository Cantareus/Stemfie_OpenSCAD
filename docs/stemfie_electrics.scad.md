# LibFile: stemfie\_electrics.scad

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

    include <stemfie_electrics.scad>

## Table of Contents

- [`battery_holder()`](#module-battery_holder)
- [`motor_shaft()`](#module-motor_shaft)
- [`motor_shaft_yellow_gearbox()`](#module-motor_shaft_yellow_gearbox)
- [`motor_shaft_N20()`](#module-motor_shaft_n20)
- [`motor_case_N20()`](#module-motor_case_n20)
- [`motor_case_yellow_gearbox()`](#module-motor_case_yellow_gearbox)
- [`terminal_cutout()`](#module-terminal_cutout)
- [`tab_connector()`](#module-tab_connector)
- [`tab_connector_cutout()`](#module-tab_connector_cutout)


### Module: battery\_holder()

**Usage:** 

- battery\_holder(half\_only = true);

**Description:** 

Creates a battery holder for two 10440 lithium batteries.

<br/>

**Example 1:** 

<img align="left" alt="battery\_holder() Example 1" src="images\stemfie_electrics\battery_holder.png" width="320" height="240">

    include <stemfie_electrics.scad>
    battery_holder(half_only = true);

<br clear="all" />

---

### Module: motor\_shaft()

**Usage:** 

- motor\_shaft(length = 1, thread\_length = 0.75);

**Description:** 

Creates a internally threaded motor shaft.

<br/>

**Example 1:** 

<img align="left" alt="motor\_shaft() Example 1" src="images\stemfie_electrics\motor_shaft.png" width="320" height="240">

    include <stemfie_electrics.scad>
    motor_shaft();

<br clear="all" />

---

### Module: motor\_shaft\_yellow\_gearbox()

**Usage:** 

- motor\_shaft\_yellow\_gearbox();

**Description:** 

Creates STEMFIE motor shaft to fit STEMFIE gearbox created from yellow motor gearbox.

---

### Module: motor\_shaft\_N20()

**Usage:** 

- motor\_shaft\_N20(N20\_shaft\_length = 4, motor\_shaft\_round\_length = 0);

**Description:** 

Creates STEMFIE motor shaft to fit N20 motor shaft.

---

### Module: motor\_case\_N20()

**Usage:** 

- motor\_case\_N20(motor\_length = 24, half\_only = true);

**Description:** 

Creates a STEMFIE motor case to fit an N20 geared motor.

<br/>

**Example 1:** Standard case

<img align="left" alt="motor\_case\_N20() Example 1" src="images\stemfie_electrics\motor_case_n20.png" width="320" height="240">

    include <stemfie_electrics.scad>
    motor_case_N20();

<br clear="all" />

<br/>

**Example 2:** 

<img align="left" alt="motor\_case\_N20() Example 2" src="images\stemfie_electrics\motor_case_n20_2.png" width="320" height="240">

    include <stemfie_electrics.scad>
    motor_case_N20(motor_length = 30, half_only = false);

<br clear="all" />

---

### Module: motor\_case\_yellow\_gearbox()

**Usage:** 

- motor\_case\_yellow\_gearbox(top\_half = false, double\_sided = false);

**Description:** 

Creates a motor case for toy yellow gearboxes.
TODO: support double_sided gearboxes.

<br/>

**Example 1:** Create top and bottom side-by-side ready to print.

<img align="left" alt="motor\_case\_yellow\_gearbox() Example 1" src="images\stemfie_electrics\motor_case_yellow_gearbox.png" width="320" height="240">

    include <stemfie_electrics.scad>
    for(i = [0,1])
      Tx((3 * BU + 1) * (1 - 2 * i) / 2)
        Ry(180 * i)
          motor_case_yellow_gearbox(top_half = i == 1);

<br clear="all" />

---

### Module: terminal\_cutout()

**Usage:** 

- terminal\_cutout(solder\_tab = true);

**Description:** 

Creates a cutout to fit a banana terminal.

<br/>

**Example 1:** 

<img align="left" alt="terminal\_cutout() Example 1" src="images\stemfie_electrics\terminal_cutout.png" width="320" height="240">

    include <stemfie_electrics.scad>
    terminal_cutout();

<br clear="all" />

<br/>

**Example 2:** Split your part in two to fit the terminal inside.

<img align="left" alt="terminal\_cutout() Example 2" src="images\stemfie_electrics\terminal_cutout_2.png" width="320" height="240">

    include <stemfie_electrics.scad>
    difference()
    {
      BU_cube([2,1,1]);
    
      BU_Tx(1)
        Ry(90)
          Rz(90)
            terminal_cutout();
    
      Tz(1.5 * BU)
        cube(3 * BU, center = true);
    }

<br clear="all" />

---

### Module: tab\_connector()

**Usage:** 

- tab\_connector(length = 1);

**Description:** 

Creates a tab to semi-permanently connect STEMFIE half blocks together.

<br/>

**Example 1:** tabs for connecting 1 to 4 block units wide objects.

<img align="left" alt="tab\_connector() Example 1" src="images\stemfie_electrics\tab_connector.png" width="320" height="240">

    include <stemfie_electrics.scad>
    for(i=[1:4])
      BU_Tx(i - 1)
        tab_connector(i);

<br clear="all" />

---

### Module: tab\_connector\_cutout()

**Usage:** 

- tab\_connector\_cutout(length = 1, C = true);

**Description:** 

Creates a tab cutout to semi-permanently connect STEMFIE half blocks together.

<br/>

**Example 1:** 

<img align="left" alt="tab\_connector\_cutout() Example 1" src="images\stemfie_electrics\tab_connector_cutout.png" width="320" height="240">

    include <stemfie_electrics.scad>
    difference()
    {
      BU_cube([1, 1, 1]);
    
      tab_connector_cutout(length = 1, C = true);
    }

<br clear="all" />

---

