// Support Test
// 
// by Dotdash32 (JDeWitt)

$fa = 1;
$fs = 0.5;
thickness = 1;
height = 10;
bottomPerimeterMultiplier = 1.5; //how much extra around under parts

module FloatingSphere(length, width, rotation) { 
// Create a sphere floating in air with a dangling tab
// rotate about center point with 'rotation' for both sphere and cube
    rotate([0,0, rotation]){
        union() {
            translate([length/2,0,-thickness/2]) cube([length, width, thickness], center=true);
            difference() {
                translate([length, 0,0]) sphere(d=width);
                translate([length, 0, width]) cube(width*2,center=true);
            }
        }
    }
    
}

module FloatingCube(length, width, rotation) {
// Create a cube floating in air with a dangling tab
    rotate([0,0,rotation]){
        union() {
            translate([length/2,0,-thickness/2]) cube([length, width, thickness], center=true);
            translate([length,0, -width/4]) cube([width,width,width/2], center=true);
        }
    }
}

module SupportTest(length, width, towerOD) {
    union() {
        // translate([length-towerOD,length-towerOD,thickness/2]) cube([length+towerOD, length+towerOD,thickness],center=true);
        //create bottom tab for floating sphere
        translate([length,0,0]) cylinder(h=thickness,d=width*bottomPerimeterMultiplier);
        translate([length/2,0,thickness/2]) cube([length,width,thickness],center=true);

        // create bottom tab for floating cube
        translate([0,length,thickness/2]) cube([width*bottomPerimeterMultiplier,width*bottomPerimeterMultiplier,thickness],center=true);
        translate([0,length/2,thickness/2]) cube([width,length,thickness],center=true);

        // finish bottom with little circle
        cylinder(d=towerOD,h=thickness);


        translate([0,0,height/2]) difference() {
            union() {
                cylinder(h=height, d=towerOD,center=true);
                translate([0,0,height/2]) {
                    FloatingSphere(length, width,0);
                    FloatingCube(length, width,90);
                    FloatingSphere(length, width,180);
                    FloatingCube(length, width,270);
        }
            }
            cylinder(h=height, d=towerOD-2*thickness, center=true);    
        }
        
    }
}
length = 10;
width = 5;
//translate([0,0,-1]) FloatingSphere(length,width,0);
//FloatingCube(length, width,90);
SupportTest(length,width,5);
