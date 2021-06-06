// Support Test
// 
// by Dotdash32 (JDeWitt)

thickness = 1;
height = 10;
module FloatingSphere(length, width, rotation) {
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
    rotate([0,0,rotation]){
        union() {
            translate([length/2,0,-thickness/2]) cube([length, width, thickness], center=true);
            translate([length,0, -width/2]) cube(width, center=true);
        }
    }
}

module SupportTest(length, width, towerOD) {
    union() {
        translate([length-towerOD,length-towerOD,thickness/2]) cube([length+towerOD, length+towerOD,thickness],center=true);
        translate([0,0,height/2+thickness]) difference() {
            cylinder(h=height, d=towerOD,center=true);
            cylinder(h=height, d=towerOD-2*thickness, center=true);    
        }
        translate([0,0,height+thickness]) {
            FloatingSphere(length, width,0);
            FloatingCube(length, width,90);
            FloatingSphere(length, width,180);
            FloatingCube(length, width,270);
        }
    }
}
length = 10;
width = 5;
//translate([0,0,-1]) FloatingSphere(length,width,0);
//FloatingCube(length, width,90);
SupportTest(length,width,5);
