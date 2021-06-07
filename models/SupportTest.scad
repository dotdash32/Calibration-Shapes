// Support Test
// 
// by Dotdash32 (JDeWitt)

// rendering aids
$fa = 1; //min fragment angle
$fs = 0.5; // min fragment size

//parameters
thickness = 1; //primary thickness of walls
height = 10; //height of tower
length = 10; //extension of objects from tower
width = 5; // width of extension tabs, also controls feature size
bottomPerimeterMultiplier = 1.5; //how much extra for parts with matieral under (test "Everywhere" supports)
towerOD = 5; //diameter of riser tower

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
                cylinder(h=height, d=towerOD,center=true); // main tower
                translate([0,0,height/2]) {
                    FloatingSphere(length, width,0);    //sphere for Everywhere
                    FloatingCube(length, width,90);     //cube   for Everywhere
                    FloatingSphere(length, width,180);  //sphere for Touching Buildplate
                    FloatingCube(length, width,270);    //cube   for Touching Buildplate
        }
            }
            cylinder(h=height, d=towerOD-2*thickness, center=true); // hollow center
        }
        
    }
}

SupportTest(length,width,towerOD); //
