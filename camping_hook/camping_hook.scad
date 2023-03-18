// units in mm
rod_radius = 8/2;
backplate_strength = 2;
backplate_height = 30;
hook_extra_strength = 2;
hook_size = hook_extra_strength/2 + rod_radius;
echo("using hook size ", hook_size, " expected hook width is ", 2*hook_size);

module hook() {
  difference() {
    union() {
      rotate_extrude(angle=-90, , $fn=50) {
        translate([hook_size,0])
          circle(hook_size, , $fn=50);
      }
      translate([hook_size, 0, 0]) sphere(r = hook_size, $fn=50);
    }
    for (offset = [0 : 1 : hook_size]) {
      translate([rod_radius + 0.5*offset,offset,-50]) rotate([0,0,0]) cylinder(h=100, r=rod_radius, , $fn=50);
      translate([rod_radius,offset,-50]) rotate([0,0,0]) cylinder(h=100, r=rod_radius);
    }
  }
}

union() {
  color("cyan") hook();
  // add backplate, with a bit of extra size to increase the area on which I can put glue
  color("red") rotate([90,0,0]) translate([-backplate_strength/2+0.1, hook_size/2, hook_size*2]) cube([backplate_strength, hook_size * 3, backplate_height], center=true);
}
