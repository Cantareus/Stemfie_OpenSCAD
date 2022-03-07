include <stemfie.scad>

Terminal_Panel_Diameter = 8 + Clearance;
Terminal_Panel_Thickness = 2;
Terminal_Max_Diameter = 11 + Clearance;
Terminal_Length = 10;

module motor_shaft(length = 1)
{
  D()
  {
    Cy(d = BU, h = BU - 0.4, C = false);

    BU_Tz(1)
      Rx(180)
        thread(length = 0.75, center = false, internal = true, bevel = [true, false]);
  }
}

module motor_shaft_N20(shaft_length = 4)
{
  Rx(180)
    D()
    {
      U()
      {
        motor_shaft(length = 1);

        Tz(-2)
          Cy(d = 9, h = 2, C = false);
      }
      Tz(-2)
      {
        D()
        {
          Cy(d = 3, h = 7.6);


          Ty(1.5)
            Cu([3,1,10]);
        }
        Ty(0.5)
          Cu([3,1,7.6]);
      }
    }
}

module motor_case_N20(motor_length = 24, half_only = true, banana_shaft = 8, banana_nut = 11)
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

    //Motor rear end and banana solder tab space.
    BU_Ty(-case_length / 2)
    {
      Ty(9)
        Cu([BU * 2, 6, 5.5]);

      T(-motor_width / 2, 6, -5.5/2)
        Cu([motor_width, case_length * BU - motor_length - 6, 5.5], C = false);
    }

      
    

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
      BU_Tx(1)
      {
        BU_Ty(-case_length / 2)
          Rx(-90)
          {
            Cy(h = 5, d = banana_shaft + Clearance);

            Tz(7)
              Cy(h = 10, d = banana_nut + Clearance);
          }
      }
      
    }
  }
}


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

module tab_connector_cutout(length = 1, C = true)
{
  BU_Tz(C?-length/2:0)
  Tx(-2.5)
  Ty(-1.5)
  {
    Tz(-0.1)
    Cu([5,3,2.1], C = false);
    Cu([3,3,length * BU], C = false);
    Tz(length * BU - 2)
    Cu([5,3,2.1], C = false);
  }
  

}