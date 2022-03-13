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

Terminal_Panel_Diameter = 6;
Terminal_Panel_Thickness = 2;
Terminal_Max_Diameter = 9.5;
Terminal_Nut_Length = 3;
Terminal_Length = 9;

connecting_method = "Clip"; //[Clip, Tab, Filament Rivet, None]

module potentiometer_knob(shaft_length, thread_length)
{
  gap = 0.4;
  pot_shaft_diameter = 6.3;
  height = shaft_length + thread_length * BU + gap;

  D()
  {
    LiEx(height, C = false)
    {
      offset(r = 1)
      offset(-1)
      D()
      {
        Ci(d = BU);
        rotN(N = 10, r = BU/ 2)
          Ci(d=1.5);
      }
    }
    
    Tz(height)
      Rx(180)
        thread(thread_length, center = false, internal = true, bevel = [true,false]);
    Cy(d = pot_shaft_diameter, h = shaft_length * 2, $fn = 19);
    Cy(d1 = 8, d2 = 6, h = 4, $fn = 19);
  }
}

module manual_dc_speed_controller(top_half = false)
{
  PCB_dimensions = [16, 33.5, 1.6] + [0, Clearance, Clearance];

  board_mid = BU/2 - 2.8 - PCB_dimensions.z / 2;

  D()
  {
    Ry(top_half?180:0)
    D()
    {
      BU_cube([3, 3, 1]);

      //PCB Space
      Tz(-board_mid + 3)
      Cu([PCB_dimensions.x, PCB_dimensions.y, PCB_dimensions.z + 6]);
      //PCB Bottom component space
      Cu([PCB_dimensions.x, PCB_dimensions.y, BU - 1.6] - [0, 2, 0]);

      //Programming plug
      BU_Ty(1.5)
      Tz(-board_mid + PCB_dimensions.z/2 + 1.7)
        Cu([8.4,5,3.5]);

      //Potentiometer hole
        hole(depth = 0.5, center = false);

      RKz(180)
      RKy(180)
        BU_T(x = -1, y = 1.5)
          Rx(-90)
          terminal_cutout();
      MKy()
        T(x = -(BU * 1.5 - 1), y = -1.5 * BU + Terminal_Panel_Thickness, z = -board_mid)
          Cu(3 * BU - 2, 5, BU - 2 - board_mid, C = false);

      MKx()
        BU_Tx(1)
        {
          hole();
          MKy()
            BU_Tx(0.5)
            Ty(0.5 * BU)
              Rz(180)
                connector_cutout();
        }
    }

    BU_Tz(0.5)
      cube([3, 3, 1] * BU + [1,1,0], center = true);
  }

  if(top_half)
  {
    MKx()
      BU_Tz(-0.5)
        T(x = -PCB_dimensions.x/2, y = -5)
          Cu([2,10,BU/2 + board_mid - PCB_dimensions.z/2 - Clearance], C = false);
  }
  
}
// Module: battery_holder()
// Usage:
//   battery_holder(half_only = true);
// Description:
//   Creates a battery holder for two 10440 lithium batteries.
// Example(3D):
//   battery_holder(half_only = true);
module battery_holder(half_only = true)
{
  battery_diameter = 10;
  battery_length = 44;
  
  case_width = 2;
  case_height = 1;
  case_length = 6;
  D()
  {
    BU_Ty(case_length/2 - 2)
    BU_cube([case_width, case_length, case_height]);

    if(half_only)
      BU_Tz(0.5)
      BU_Ty(case_length/2 - 2)
        cube([case_width, case_length, case_height] * BU + [1,1,0], center = true);
    MKx()
      BU_Tx(0.5)
        BU_Ty(2)
          Rx(90)
            Cy(d = battery_diameter + Clearance * 2, h = battery_length);
  }
}

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
    
    Cy(d = BU - Clearance * 2, h = length * BU - Clearance, C = false);

    BU_Tz(length - Clearance / BU)
      Rx(180)
        thread(length = thread_length, center = false, internal = true, bevel = [true, false]);
  }
}

// Module: motor_shaft_yellow_gearbox()
// Usage:
//   motor_shaft_yellow_gearbox();
// Description:
//   Creates STEMFIE motor shaft to fit STEMFIE gearbox created from yellow motor gearbox.
// Example(3D)
//   motor_shaft_yellow_gearbox();
module motor_shaft_yellow_gearbox()
{
  D()
  {
    Tz(2 * Clearance/BU)
      motor_shaft(length = 1 - 2 * Clearance/BU, thread_length = 0.5);


    cutout((5.64 - Clearance * 2)/BU, center = false, bevel = [false, true])
      I()
      {
        Ci(d = 5.5);

        Sq(6,3.9);
      }
  }
}

// Module: motor_shaft_N20()
// Usage:
//   motor_shaft_N20(N20_shaft_length = 4, motor_shaft_round_length = 0);
// Description:
//   Creates STEMFIE motor shaft to fit N20 motor shaft.
// Example(3D)
//   motor_shaft_N20(N20_shaft_length = 7);
module motor_shaft_N20(N20_shaft_length = 4, motor_shaft_round_length = 0)
{
  min_thread_length = 0.5;
  thread_motor_shaft_gap = 0.4;
  shaft_length = ceil((min_thread_length + (N20_shaft_length + thread_motor_shaft_gap - BU/2) / BU) * 2) / 2;
  thread_length = shaft_length - (N20_shaft_length + thread_motor_shaft_gap - 2) / BU;

  BU_Tz(shaft_length)
    Rx(180)
      D()
      {
        U()
        {
          motor_shaft(length = shaft_length, thread_length = thread_length);

          Tz(-BU/2 + 0.8)
            Cy(d = 9, h = BU/2, C = false);
        }

        Tz(-BU/2 + 0.8)
        {
          Tz(motor_shaft_round_length)
          cutout(depth = (N20_shaft_length - 0.8) / BU, bevel = [false, motor_shaft_round_length == 0], center =  false)
          {
            
            CiH(d = 3);

            Ty(-0.5)
              Sq(3,1);
          }

          if(motor_shaft_round_length > 0)
            cutout(depth = (motor_shaft_round_length) / BU, bevel = [false, true], center =  false)
              Ci(d = 3.2);
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
    BU_Ty(case_length / 2 - 0.5)
      Ty(-motor_length/2)
        Cu([motor_width + Clearance, motor_length + Clearance * 2, motor_height + Clearance]);

    //Motor shaft opening
    BU_Ty(case_length / 2)
      Rx(90)
        Cy(d = 10, h = BU + 2);

    //Motor rear end space.
    BU_Ty(-case_length / 2)
      T(-motor_width / 2, Terminal_Panel_Thickness, -5.5/2)
        Cu([motor_width, case_length * BU - motor_length, 5.5], C = false);

    RKy(180)
    {
      //STEMFIE mounting holes
      BU_Ty(0.5)
        BU_Tx(1)
          hole_grid([1,case_length - 1]);
      
      //Tab connector holes
      MKy()
        BU_T(x = -1.5, y = case_length/2 - 1)
          connector_cutout();

      //Banana terminal cutout
      BU_Tx(-1)
        BU_Ty(-case_length / 2)
          Rx(90)
            terminal_cutout();
    }
  }
}

// Module: motor_case_yellow_gearbox()
// Usage:
//   motor_case_yellow_gearbox(top_half = false, double_sided = false);
// Description:
//   Creates a motor case for toy yellow gearboxes.
//   TODO: support double_sided gearboxes.
// Example(3D): Create top and bottom side-by-side ready to print.
//   for(i = [0,1])
//     Tx((3 * BU + 1) * (1 - 2 * i) / 2)
//       Ry(180 * i)
//         motor_case_yellow_gearbox(top_half = i == 1);
module motor_case_yellow_gearbox(top_half = false, double_sided = false)
{
  
  case_size = [3, 6, 2];
  output_crown_distance = 11.4;
  output_motor_distance = output_crown_distance + 14;
  motor_length = 25;

  D()
  {
    U()
    {
      BU_Ty(-1.5)
        D()
        {
            BU_cube(case_size);

            BU_cube([20 / BU, case_size.y - 4/BU, case_size.z - 4 / BU]);
        }

      MKx()
        BU_T(x=1,y=1)
          hole(depth = 2, neg = false);

      
      //Output shaft gear space
      Tz(-1)
        Sz(-1)
          Ri(D = 7.5, d = 5.5, h = case_size.z/2 * BU - 1, C = false);
      Tz(9)
        Ri(D = 7.5, d = 5.5, h = case_size.z/2 * BU - 9, C = false);

      Ty(-output_crown_distance)
      {
        D()
          {
            U(){
              Ri(D = 4, d = 2.2, h = case_size.z * BU);

              Tz(-4.7 - (18-13)/2 - 0.3)
                Cy(d = 4, h = 0.6);

              Tz(18-4.7 - (18-13)/2 + 0.3)
                Cy(d = 4, h = 0.6);
            }
        }
      }

      //Motor housing
      Ty(-output_motor_distance)
      {
          Ty(2-32/2)
            Cu([case_size.x * BU - 3, 32, case_size.z * BU]);
      }
    }

    //Motor housing
    Ty(-output_motor_distance)
    {
      //Front bearing
      Rx(-90)
        Tz(-0.1)
          Cy(d = 6, h = 3, C = false);

      //Main motor body
      Rx(90)
      {
        I()
        {
          Cy(d=20, h = 25, C = false);

          Tz(25/2)
            Cu([26,15,25]);
        }
        //End cap
        Cy(d=10, h = 28, C = false);
      }
    }

    //Output shaft space
    Cy(d = 5.7, h = case_size.z * BU, C = false);
    
    //Reinforcing shaft perimeters
    MKz()
    {
      BU_Tz(-case_size.z/2)
        Tz(0.6)
        {
          //Output shaft
          D()
          {
            Ri(D = 8, d = 7.7,h = 2, C = false);
            RKz(90)
              Cu([1.6,10,10]);
          }

          //Crown gear shaft
          Ty(-output_crown_distance)
          {
            D()
            {
            Ri(D = 4.4, d = 4.1,h = 2, C = false);

            RKz(90)
              Cu([1.6,10,10]);
            }
          }
        }
    }

    Ty(-output_crown_distance)
    {
      Tz(-4.7)
      {
        //Crown shaft gear space
        Cy(d = 15, h = 13.2, C = false);
      }
    }
    //Two corner STEMFIE  holes
    MKx()
      BU_T(1,1)
        hole(depth = 2, neg = true, center = true);
  
    //Connecting tabs
    MKx()
      BU_Ty(-1.5)
        Tx(-1.5 * BU)
          forY(M = 3, dy = BU * 2)
            connector_cutout(length = 2);


    //Side threads
    BU_Ty(-1.5)
      RKy(180)
        BU_Tx(1.5)
          Ry(-90)
            forXY(N = 2, M = 4, dx = BU, dy = BU)
              thread(0.5, internal = true, bevel = [true, false], center = false);
    
    //Terminals
    BU_Tz(-0.5)
    {
      BU_Ty(-4.5)
        RKy(180)
          BU_Tx(-1)
            Rx(90)
              terminal_cutout();

      T(y = -(output_motor_distance + 20 + 4.5 * BU - 2) / 2, z = 1.1)
        Cu([case_size.x * BU - 4, 4.5 * BU - 2 - output_motor_distance -20,BU - 2]);
    }

    //Cut part in half
    BU_Tz(top_half?-1:1)
      BU_Ty(-1.5)
        Cu(case_size*BU+[BU, BU, 0]);
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
      Cy(h = Terminal_Length + 0.2, d = Terminal_Panel_Diameter + Clearance, C = false);

    Tz(Terminal_Panel_Thickness)
      Rz(30)
      Cy(h = Terminal_Nut_Length, d = Terminal_Max_Diameter + Clearance, C = false, $fn = 6);

    Tz(Terminal_Panel_Thickness + Terminal_Nut_Length / 2)
      BU_Tx(1/2)
        Cu(BU + 0.1, 5.5, Terminal_Nut_Length);
  }
}



module connector_cutout(length = 1)
{
  if(connecting_method == "Clip")
    clip_connector_cutout(length);
  else if(connecting_method == "Tab")
    tab_connector_cutout(length);
  else if(connecting_method == "Filament Rivet")
    rivet_connector_cutout(length);
}

module connector(length = 1)
{
  if(connecting_method == "Clip")
    clip_connector(length);
  else if(connecting_method == "Tab")
    tab_connector(length);
  else if(connecting_method == "Filament Rivet")
    rivet_connector(length);
}

module rivet_connector_cutout(length = 1)
{
  Tx(3.6)
  {
    Cy(d = 2, h = length * BU);

    MKz()
      BU_Tz(length/2)
        Cy(d2 = 6, d1 = 2, h = 2);
  }
}

module rivet_connector(length = 1)
{
  Tx(3.6)
    Cy(d = 1.75, h = length * BU);
}

// Module: tab_connector()
// Usage:
//   tab_connector(length = 1);
// Description:
//   Creates a tab to semi-permanently connect STEMFIE half blocks together.
// Example(3D): tabs for connecting 1 to 4 block units wide objects.
//   for(i=[1:4])
//     BU_Tx(i - 1)
//       tab_connector(i);
module tab_connector(length = 1)
{
  Tx(1.6)
  BU_Tz(-length / 2)
  Rx(90)
  {
    bevel_plate((3-Clearance)/BU, center = true)
      D()
      {
        Sq(3 - Clearance,length * BU, center = false);

        Ty(-1)
          Tx(1.6)
            Rz(99)
              Sq(length * BU,10, center = false);
      }

    bevel_plate((3-Clearance)/BU, center = true)
      Tx(2)
        Sq(2, 2- Clearance, center = false);

    bevel_plate((3-Clearance)/BU, center = true)
      Tx(2)
        Ty(length * BU)
          Sy(-1)
            Sq(2.5, 2 - Clearance, center = false);
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
  Tx(4.1)
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


module clip_connector(length = 1)
{
  Tx(1.6)
  MKz()
    BU_Tz(-length/2)
    {
      clip_connector_end(3.2);
    }
  Rx(90)
    bevel_plate(3.2 / BU)
      Tx(1.5/2)
      Sq(1.5, length * BU);
}


module clip_connector_cutout(length = 1)
{
  width = 3.2 + Clearance;

  Rx(90)
  LiEx(width)
  offset(Clearance)
  projection()
    Rx(90)
      clip_connector(length);
}

module clip_connector_end(width = 3.2, outer_bevel = false)
{
  Rx(90)
  I()
  {
    D()
    {
      if(outer_bevel)
        bevel_plate(h = width/BU, top_bevel = false)
          Sq(BU/2, BU, center = false);
      else
        Tz(-width / 2)
        Cu(BU/2,BU,width, C = false);

      D()
      {
        T(x = 1.5 + 10, y = BU/2)
          cutout(depth = width / BU)
            Ci(d = 20,false, $fn = 64);

        bevel_plate(h = width/BU, top_bevel = false)
          Tx(BU/2)
            Rz(45)
              Sx(-1)
                Sq(3.5, 3.5, center = false);
      }
    }
    T(z = -width)
      Cu(BU/2,BU/2, width * 2, C = false);
  }
}