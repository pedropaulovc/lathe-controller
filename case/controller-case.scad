// Lathe Controller Case
// Dimensions in mm

// Main case dimensions
case_width = 127;      // 5 inches
case_depth = 80;       // 3.15 inches
case_height = 180;     // 7 inches
wall_thickness = 4;

// Component hole dimensions
display_width = 50;
display_height = 19;
pot_diameter = 16;
button_diameter = 11.9;
estop_diameter = 22;
cable_entry_diameter = 21.34;  // NPT 1/2

// Mounting post dimensions
post_diameter = 8;
post_hole_diameter = 2.5;  // For M3 tap
post_height = 10;

// Back panel screw posts
corner_post_diameter = 10;
corner_post_offset = wall_thickness;

// Rounding radius
corner_radius = 3;

// Component positions from center
display_y_offset = 60;
pot_x_offset = 35;
pot_y_offset = 35;
run_button_x_offset = -30;
run_button_y_offset = 0;
jog_button_x_offset = 30;
jog_button_y_offset = 0;
estop_y_offset = -50;

// FLORA mounting positions
flora_mount_spacing_x = 45;
flora_mount_spacing_y = 45;

// Rounded box module
module rounded_box(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];
    
    hull() {
        for (i = [0, 1]) {
            for (j = [0, 1]) {
                for (k = [0, 1]) {
                    translate([radius + i*(x-2*radius), 
                               radius + j*(y-2*radius), 
                               radius + k*(z-2*radius)])
                        sphere(r=radius);
                }
            }
        }
    }
}

// Main case module
module main_case() {
    difference() {
        // Main body with rounded corners
        rounded_box([case_width, case_depth, case_height], corner_radius);
        
        // Hollow interior
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([case_width - 2*wall_thickness, 
                  case_depth, 
                  case_height - 2*wall_thickness]);
        
        // Front panel cutouts
        translate([0, 0, case_height/2]) {
            // Display cutout
            translate([case_width/2, wall_thickness/2, display_y_offset])
                cube([display_width, wall_thickness + 2, display_height], center=true);
            
            // Speed control potentiometer
            translate([case_width/2 + pot_x_offset, -1, pot_y_offset])
                rotate([-90, 0, 0])
                cylinder(h=wall_thickness + 2, d=pot_diameter);
            
            // Run button
            translate([case_width/2 + run_button_x_offset, -1, run_button_y_offset])
                rotate([-90, 0, 0])
                cylinder(h=wall_thickness + 2, d=button_diameter);
            
            // Jog button
            translate([case_width/2 + jog_button_x_offset, -1, jog_button_y_offset])
                rotate([-90, 0, 0])
                cylinder(h=wall_thickness + 2, d=button_diameter);
            
            // Emergency stop
            translate([case_width/2, -1, estop_y_offset])
                rotate([-90, 0, 0])
                cylinder(h=wall_thickness + 2, d=estop_diameter);
        }
        
        // Top cable entry
        translate([case_width/2, case_depth/2, case_height - wall_thickness - 1])
            cylinder(h=wall_thickness + 2, d=cable_entry_diameter);
    }
    
    // Display support shelf
    translate([case_width/2 - display_width/2 - 5, wall_thickness, 
               case_height/2 + display_y_offset - display_height/2 - 5])
        cube([display_width + 10, 15, 3]);
    
    // Display bridge support
    translate([case_width/2 - display_width/2, wall_thickness, 
               case_height/2 + display_y_offset + display_height/2 - 3])
        cube([display_width, 15, 3]);
    
    // FLORA mounting posts
    for(x = [-1, 1]) {
        for(y = [-1, 1]) {
            translate([case_width/2 + x*flora_mount_spacing_x/2,
                      case_depth/2 + y*flora_mount_spacing_y/2,
                      wall_thickness]) {
                difference() {
                    cylinder(h=post_height, d=post_diameter);
                    translate([0, 0, -1])
                        cylinder(h=post_height + 2, d=post_hole_diameter);
                }
            }
        }
    }
    
    // Back panel screw posts with support structure
    for(x = [0, 1]) {
        for(z = [0, 1]) {
            translate([corner_post_offset + x*(case_width - 2*corner_post_offset),
                      case_depth - wall_thickness,
                      corner_post_offset + z*(case_height - 2*corner_post_offset)]) {
                // Support boss connecting to back wall
                hull() {
                    // Cylinder at the mounting point
                    translate([0, 0, 0])
                        rotate([90, 0, 0])
                        cylinder(h=corner_post_diameter, d=corner_post_diameter);
                    // Connection to back wall
                    translate([-corner_post_diameter/2, 0, -corner_post_diameter/2])
                        cube([corner_post_diameter, 1, corner_post_diameter]);
                }
                // Screw hole
                translate([0, 1, 0])
                    rotate([90, 0, 0])
                    cylinder(h=corner_post_diameter + 2, d=post_hole_diameter);
            }
        }
    }
}

// Back panel module
module back_panel() {
    $fn = 30;
    
    panel_width = case_width - 2*wall_thickness;
    panel_height = case_height - 2*wall_thickness;
    
    difference() {
        // Main panel
        cube([panel_width, wall_thickness, panel_height]);
        
        // Mounting holes
        for(x = [0, 1]) {
            for(z = [0, 1]) {
                translate([corner_post_offset - wall_thickness + x*(panel_width - 2*(corner_post_offset - wall_thickness)),
                          -1,
                          corner_post_offset - wall_thickness + z*(panel_height - 2*(corner_post_offset - wall_thickness))])
                    rotate([-90, 0, 0])
                    cylinder(h=wall_thickness + 2, d=3.5);  // M3 clearance
            }
        }
    }
}

// High resolution for smooth circles
$fn = 60;

// Render the main case
main_case();

// Render the back panel next to the main case for printing
translate([case_width + 20, 0, 0])
    back_panel();