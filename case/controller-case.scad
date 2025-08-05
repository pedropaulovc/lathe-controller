// Lathe Controller Case - 5" wide max 8" tall
// Front controls, top cable entry, removable back panel

// Case dimensions
case_width = 127;      // 5 inches = 127mm
case_height = 180;     // ~7 inches, under 8" limit  
case_depth = 80;       // 3.15 inches depth
wall_thickness = 3;

// Control component dimensions
display_width = 50;
display_height = 19;
pot_diameter = 16;
pushbutton_diameter = 11.9;  // 32-P-970046-01 pushbuttons
estop_diameter = 22;         // Round emergency stop

// NPT 1/2 cable entry
npt_half_diameter = 21.34;   // NPT 1/2 thread diameter

// Back panel screws
screw_diameter = 3.2;        // M3 screws
screw_head_diameter = 6;

module case_body() {
    difference() {
        // Main case body with top and open back
        union() {
            // Main walls (front, left, right, top)
            difference() {
                cube([case_width, case_depth, case_height]);
                // Remove back wall and internal cavity
                translate([wall_thickness, wall_thickness, wall_thickness])
                    cube([case_width - 2*wall_thickness, 
                          case_depth - wall_thickness + 1, 
                          case_height - 2*wall_thickness]);
            }
        }
        
        // NPT 1/2 cable entry hole in top
        translate([case_width/2, case_depth/2, case_height - wall_thickness - 1])
            cylinder(h = wall_thickness + 2, d = npt_half_diameter);
    }
}

module back_panel() {
    difference() {
        // Back panel
        cube([case_width - 2*wall_thickness, wall_thickness, case_height - 2*wall_thickness]);
        
        // Screw holes for mounting
        translate([15, -1, 15])
            cylinder(h = wall_thickness + 2, d = screw_diameter);
        translate([case_width - 2*wall_thickness - 15, -1, 15])
            cylinder(h = wall_thickness + 2, d = screw_diameter);
        translate([15, -1, case_height - 2*wall_thickness - 15])
            cylinder(h = wall_thickness + 2, d = screw_diameter);
        translate([case_width - 2*wall_thickness - 15, -1, case_height - 2*wall_thickness - 15])
            cylinder(h = wall_thickness + 2, d = screw_diameter);
    }
}

module front_panel_cutouts() {
    // 7-segment display cutout (top center)
    translate([case_width/2 - display_width/2, -1, case_height - 60])
        cube([display_width, wall_thickness + 2, display_height]);
    
    // Speed potentiometer (upper right) - round hole
    translate([case_width - 35, -1, case_height - 100])
        cylinder(h = wall_thickness + 2, d = pot_diameter, $fn = 32);
    
    // Run pushbutton 32-P-970046-01 (middle left) - round hole
    translate([25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = pushbutton_diameter, $fn = 32);
    
    // Jog pushbutton 32-P-970046-01 (middle right) - round hole
    translate([case_width - 25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = pushbutton_diameter, $fn = 32);
    
    // Emergency stop (lower center) - round hole
    translate([case_width/2, -1, 40])
        cylinder(h = wall_thickness + 2, d = estop_diameter, $fn = 32);
}

// Side mounting tabs removed per user request

module internal_mounts() {
    // FLORA mounting posts
    flora_x = 20;
    flora_y = 20;
    flora_z = 20;
    
    translate([flora_x, flora_y, flora_z]) {
        cylinder(h = 8, d = 6, $fn = 16);
        translate([0, 0, 8]) cylinder(h = 3, d = 3, $fn = 16);
    }
    
    translate([flora_x + 35, flora_y, flora_z]) {
        cylinder(h = 8, d = 6, $fn = 16);
        translate([0, 0, 8]) cylinder(h = 3, d = 3, $fn = 16);
    }
    
    translate([flora_x, flora_y + 35, flora_z]) {
        cylinder(h = 8, d = 6, $fn = 16);
        translate([0, 0, 8]) cylinder(h = 3, d = 3, $fn = 16);
    }
    
    translate([flora_x + 35, flora_y + 35, flora_z]) {
        cylinder(h = 8, d = 6, $fn = 16);
        translate([0, 0, 8]) cylinder(h = 3, d = 3, $fn = 16);
    }
    
    // Display mounting posts
    display_x = case_width/2 - 25;
    display_y = wall_thickness + 5;
    display_z = case_height - 80;
    
    translate([display_x, display_y, display_z]) {
        cube([50, 8, 5]);
    }
    
    // Back panel screw posts
    translate([15, case_depth - wall_thickness - 8, 15]) {
        cylinder(h = 8, d = 8, $fn = 16);
        cylinder(h = 12, d = screw_diameter, $fn = 16);
    }
    translate([case_width - 15, case_depth - wall_thickness - 8, 15]) {
        cylinder(h = 8, d = 8, $fn = 16);
        cylinder(h = 12, d = screw_diameter, $fn = 16);
    }
    translate([15, case_depth - wall_thickness - 8, case_height - 15]) {
        cylinder(h = 8, d = 8, $fn = 16);
        cylinder(h = 12, d = screw_diameter, $fn = 16);
    }
    translate([case_width - 15, case_depth - wall_thickness - 8, case_height - 15]) {
        cylinder(h = 8, d = 8, $fn = 16);
        cylinder(h = 12, d = screw_diameter, $fn = 16);
    }
}

// Main assembly - one piece case with removable back
module lathe_controller_case() {
    difference() {
        union() {
            case_body();
            internal_mounts();
        }
        
        front_panel_cutouts();
    }
}

// Generate the case and removable back panel
translate([0, 0, 0]) lathe_controller_case();
translate([case_width + 10, 0, wall_thickness]) back_panel();

// Print settings comments:
// Layer height: 0.2mm
// Infill: 20%
// Supports: None needed
// Print orientation: Case upright, back panel flat