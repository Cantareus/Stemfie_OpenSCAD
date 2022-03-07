// LibFile: stemfie_electrics.scad 
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
//   Please check https://stemfie.org/license for more information or before using stemfie commercially.  
//   .
//   OpenSCAD script for creating Stemife.org parts.  
//   .
//   Feel free to adapt and improve and share your OpenSCAD script (please contact Paulo Kiefe)  
//   .
//   Contact: paulo.kiefe@stemfie.org (https://stemfie.org)
// Includes:
//   include <stemfie_electrics.scad>

include <stemfie.scad>

Terminal_Panel_Diameter = 8;
Terminal_Panel_Thickness = 2;
Terminal_Max_Diameter = 11;
Terminal_Length = 12;

// Module: motor_shaft()
// Usage:
//   motor_shaft(length = 1, thread_length = 0.75);
// Description:
//   Creates a internally threaded motor shaft.
// Example(3D):
//   motor_shaft();
module motor_shaft(length = 1, thread_length = 0.75)
{
  D()
  {
    Tz(Clearance)
      Cy(d = BU - Clearance * 2, h = length * BU - Clearance, C = false);

    BU_Tz(length)
      Rx(180)
        thread(length = thread_length, center = false, internal = true, bevel = [true, false]);
  }
}

// Module: motor_shaft_N20()
// Usage:
//   motor_shaft_N20(N20_shaft_length = 4);
// Description:
//   Creates STEMFIE motor shaft to fit N20 motor shaft.
// Example(3D)
//   motor_shaft_N20(N20_shaft_length = 7);
module motor_shaft_N20(N20_shaft_length = 4)
{
  min_thread_length = 0.5;
  thread_motor_shaft_gap = 0.4;
  shaft_length = ceil(min_thread_length + (N20_shaft_length + thread_motor_shaft_gap - 2) / BU);
  thread_length = shaft_length - (N20_shaft_length + thread_motor_shaft_gap - 2) / BU;

  Rx(180)
    D()
    {
      U()
      {
        motor_shaft(length = shaft_length, thread_length = thread_length);

        Tz(-2)
          Cy(d = 9, h = 3, C = false);
      }
      Tz(-2)
      {
        D()
        {
          U()
            Cy(d = 3, h = (N20_shaft_length - Clearance) * 2);

          Ty(1.5)
            Cu([3, 1.1, N20_shaft_length * 2]);
        }

        Ty(0.5)
          Cu([3,1, (N20_shaft_length - Clearance) * 2]);
      }
    }
}


// Module: motor_case_N20()
// Usage:
//   motor_case_N20(motor_length = 24, half_only = true);
// Description:
//   Creates a STEMFIE motor case to fit an N20 geared motor.
// Example(3D): Standard case
//   motor_case_N20();
// Example(3D):
//   motor_case_N20(motor_length = 30, half_only = false);
module motor_case_N20(motor_length = 24, half_only = true)
{
  motor_width = 12;
  motor_height = 10;
  case_length = ceil(motor_length / BU) + 1;

  D()
  {
    //Main block
    BU_cube([3, case_length,1]);
    
    //Remove half
    if(half_only)
      BU_Tz(0.5)
        Cu([3 * BU + 1, case_length * BU + 1, BU], C = true);

    //Motor cutout
    BU_Ty(case_length / 2)
      Ty(-motor_length/2 - 2)
        Cu([motor_width + Clearance, motor_length + Clearance * 2, motor_height + Clearance]);

    //Motor shaft opening
    BU_Ty(case_length / 2)
      Rx(90)
        Cy(d = 10, h = BU + 2);

    //Motor rear end space.
    BU_Ty(-case_length / 2)
      T(-motor_width / 2, 6, -5.5/2)
        Cu([motor_width, case_length * BU - motor_length - 6, 5.5], C = false);

    RKy(180)
    {
      //STEMFIE mounting holes
      BU_Ty(0.5)
        BU_Tx(1)
          hole_grid([1,case_length - 1]);
      
      //Tab connector holes
      BU_T(x = -1.1, y = case_length/2 - 1)
        tab_connector_cutout();
      BU_T(x = 0.4, y = -case_length/2)
        Ty(3)
          tab_connector_cutout();

      //Banana terminal cutout
      BU_Tx(-1)
        BU_Ty(-case_length / 2)
          Rx(90)
            terminal_cutout();
    }
  }
}

// Module: terminal_cutout()
// Usage:
//   terminal_cutout(solder_tab = true);
// Description:
//   Creates a cutout to fit a banana terminal.
// Example(3D):
//   terminal_cutout();
// Example(3D): Split your part in two to fit the terminal inside.
//   difference()
//   {
//     BU_cube([2,1,1]);
//   
//     BU_Tx(1)
//       Ry(90)
//         Rz(90)
//           terminal_cutout();
//   
//     Tz(1.5 * BU)
//       cube(3 * BU, center = true);
//   }
module terminal_cutout(solder_tab = true)
{
  Sz(-1)
  {
    Tz(-0.1)
      Cy(h = Terminal_Panel_Thickness + 0.2, d = Terminal_Panel_Diameter + Clearance, C = false);

    Tz(Terminal_Panel_Thickness)
      Cy(h = Terminal_Length - Terminal_Panel_Thickness, d = Terminal_Max_Diameter + Clearance, C = false);

    Tz(Terminal_Length - 3)
      BU_Tx(1/2)
        Cu(BU + 0.1, 5.5, 6);
  }
}

// Module: tab_connector()
// Usage:
//   tab_connector(length = 1);
// Description:
//   Creates a tab to semi-permanently connect STEMFIE half blocks together.
// Example(3D): tabs for connecting 1 to 4 block units wide objects.
//   rotate([90,0, 0])
//     for(i=[1:4])
//       BU_Tx(i)
//         tab_connector(i);
module tab_connector(length = 1)
{
  {
    D()
    {
      U()
      {
        Cu([4.5 - Clearance,3- Clearance,2- Clearance], C = false);
        Cu([3- Clearance,3- Clearance,length * BU- Clearance * 2], C = false);
        Tz(length * BU - 2)
        Cu([5- Clearance,3- Clearance,2- Clearance], C = false);
      }
        Ty(-1)
        Tx(1.6)
        Ry(-99)
        Cu([length * BU,10,10], C = false);
    }
    
  }
}

// Module: tab_connector_cutout()
// Usage:
//   tab_connector_cutout(length = 1, C = true);
// Description:
//   Creates a tab cutout to semi-permanently connect STEMFIE half blocks together.
// Example(3D): 
//   difference()
//   {
//     BU_cube([1, 1, 1]);
//   
//     tab_connector_cutout(length = 1, C = true);
//   }
module tab_connector_cutout(length = 1, C = true)
{
  BU_Tz(C?-length/2:0)
    T(x = -2.5, y = -1.5)
    {
      Tz(-0.1)
        Cu([5,3,2.1], C = false);

      Cu([3,3,length * BU], C = false);

      Tz(length * BU - 2)
        Cu([5,3,2.1], C = false);
  }
}