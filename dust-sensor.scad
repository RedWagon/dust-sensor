EXTRA_MARGIN = 6;
SENSOR_WIDTH = 70 + EXTRA_MARGIN;
SENSOR_HEIGHT = 70 + EXTRA_MARGIN;

WALL_THICKNESS = 2;
WALL_HEIGHT = 6;

HOLE_DIAMETER = 2.7;
HOLE_HOLDER = 6.65;

BASE_THICKNESS = 1;
CORNER_CURVE_DIAMETER = 3;

CABLE_PORT_HEIGHT = 21;

AIR_INTAKE_DIAMETER = 6.23;

PCB_THICKNESS = 1.64;
TOTAL_PCB_THICKNESS = 4.10;
CHIP_THICKNESS = TOTAL_PCB_THICKNESS - PCB_THICKNESS + 0.5;
SLOT_HEIGHT = CHIP_THICKNESS + 2;


$fn = 128;
dust_sensor();  


module dust_sensor(dust_sensor) {    
    difference(){
        union(){
            translate([0, 0, BASE_THICKNESS/2])
            base();
            
            translate([0, 0, WALL_HEIGHT/2])
            base_with_walls();        
        };        
              
        // CABLES
        color("red")
        translate([-SENSOR_WIDTH/2, (SENSOR_HEIGHT-CABLE_PORT_HEIGHT-EXTRA_MARGIN)/2, BASE_THICKNESS+WALL_HEIGHT/2])
        cube([8,CABLE_PORT_HEIGHT,WALL_HEIGHT], true);         
        
        // AIR INTAKE      
        color("red")
        translate([SENSOR_WIDTH/2, (SENSOR_HEIGHT-AIR_INTAKE_DIAMETER-EXTRA_MARGIN)/2-20, BASE_THICKNESS+WALL_HEIGHT/2])
        cube([8,AIR_INTAKE_DIAMETER,WALL_HEIGHT], true);         
    }            
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS/2])    
    screw_slot();
    
    // Extra stabilizer
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+25, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS/2])        
    stabiliser();  
    
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-22.47, BASE_THICKNESS/2])    
    screw_slot();    
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS/2])    
    screw_slot();       
    
    // Extra stabilizer
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS/2])    
    stabiliser();
}

module rounded_corners(width, height, depth, corner_curve){
    x_translate = width-corner_curve;
    y_translate = height-corner_curve;     
    
    hull(){
            translate([-x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);    
            
            translate([-x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);

            translate([x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
            
            translate([x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
    }        
}

module base(){
    x_translate = SENSOR_WIDTH-CORNER_CURVE_DIAMETER;
    y_translate = SENSOR_HEIGHT-CORNER_CURVE_DIAMETER;    
    
    difference(){
         rounded_corners(SENSOR_WIDTH, SENSOR_HEIGHT, BASE_THICKNESS, CORNER_CURVE_DIAMETER);
         cube([SENSOR_WIDTH-22,SENSOR_HEIGHT-22,BASE_THICKNESS*2], true);            
    }
}

module base_with_walls(){    
    difference(){
        // OUTSIDE
        rounded_corners(SENSOR_WIDTH+WALL_THICKNESS*2, SENSOR_HEIGHT+WALL_THICKNESS*2, WALL_HEIGHT, CORNER_CURVE_DIAMETER);        
        
        // INSIDE
        rounded_corners(SENSOR_WIDTH, SENSOR_HEIGHT, WALL_HEIGHT*2, CORNER_CURVE_DIAMETER);
    }
}

module stabiliser(){
    translate([0,0,CHIP_THICKNESS/2])
    cylinder(CHIP_THICKNESS,HOLE_HOLDER/2, HOLE_HOLDER/2, true);     
}

module screw_slot(){
    union(){
        translate([0,0,CHIP_THICKNESS/2])
        cylinder(CHIP_THICKNESS,HOLE_HOLDER/2, HOLE_HOLDER/2, true);            
        
        translate([0,0,SLOT_HEIGHT/2])
        cylinder(SLOT_HEIGHT,HOLE_DIAMETER/2, HOLE_DIAMETER/2, true);                    
    }
}
