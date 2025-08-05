// Lathe Controller Case - 5" wide max 8" tall
// Front controls, side mounting design

// Case dimensions
case_width = 127;      // 5 inches = 127mm
case_height = 180;     // ~7 inches, under 8" limit  
case_depth = 80;       // 3.15 inches depth
wall_thickness = 3;

// Control component dimensions
display_width = 50;
display_height = 19;
pot_diameter = 16;
switch_diameter = 12;
estop_diameter = 22;

// Mounting tab dimensions
tab_width = 20;
tab_height = 40;
mounting_hole_diameter = 6;  // M5 mounting holes

module case_body() {
    difference() {
        // Main case body
        cube([case_width, case_depth, case_height]);
        
        // Internal cavity
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([case_width - 2*wall_thickness, 
                  case_depth - 2*wall_thickness, 
                  case_height - wall_thickness]);
    }
}

module front_panel_cutouts() {
    // 7-segment display cutout (top center)
    translate([case_width/2 - display_width/2, -1, case_height - 60])
        cube([display_width, wall_thickness + 2, display_height]);
    
    // Speed potentiometer (upper right)
    translate([case_width - 35, -1, case_height - 100])
        cylinder(h = wall_thickness + 2, d = pot_diameter);
    
    // Run switch (middle left)
    translate([25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = switch_diameter);
    
    // Jog switch (middle right)
    translate([case_width - 25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = switch_diameter);
    
    // Emergency stop (lower center)
    translate([case_width/2, -1, 40])
        cylinder(h = wall_thickness + 2, d = estop_diameter);
}

module side_mounting_tabs() {
    // Left mounting tab
    translate([-tab_width, case_depth/2 - tab_height/2, case_height/2 - tab_height/2]) {
        difference() {
            cube([tab_width, tab_height, wall_thickness]);
            // Mounting holes
            translate([tab_width/2, tab_height/4, -1])
                cylinder(h = wall_thickness + 2, d = mounting_hole_diameter);
            translate([tab_width/2, 3*tab_height/4, -1])
                cylinder(h = wall_thickness + 2, d = mounting_hole_diameter);
        }
    }
}

module internal_mounts() {
    // FLORA mounting posts
    flora_x = 20;
    flora_y = 20;
    flora_z = 20;
    
    translate([flora_x, flora_y, flora_z]) {
        cylinder(h = 8, d = 6);
        translate([0, 0, 8]) cylinder(h = 3, d = 3); // M3 screw post
    }
    
    translate([flora_x + 35, flora_y, flora_z]) {
        cylinder(h = 8, d = 6);
        translate([0, 0, 8]) cylinder(h = 3, d = 3);
    }
    
    translate([flora_x, flora_y + 35, flora_z]) {
        cylinder(h = 8, d = 6);
        translate([0, 0, 8]) cylinder(h = 3, d = 3);
    }
    
    translate([flora_x + 35, flora_y + 35, flora_z]) {
        cylinder(h = 8, d = 6);
        translate([0, 0, 8]) cylinder(h = 3, d = 3);
    }
    
    // Display mounting posts
    display_x = case_width/2 - 25;
    display_y = wall_thickness + 5;
    display_z = case_height - 80;
    
    translate([display_x, display_y, display_z]) {
        cube([50, 8, 5]);
    }
}

module cable_management() {
    // Cable entry hole (bottom)
    translate([case_width/2, case_depth/2, -1])
        cylinder(h = wall_thickness + 2, d = 20);
    
    // Cable strain relief groove
    translate([case_width/2 - 10, case_depth/2 - 10, 0])
        cube([20, 20, 5]);
}

// Main assembly
module lathe_controller_case() {
    difference() {
        union() {
            case_body();
            side_mounting_tabs();
            internal_mounts();
        }
        
        front_panel_cutouts();
        cable_management();
    }
}

// Generate the case
lathe_controller_case();

// Print settings comments:
// Layer height: 0.2mm
// Infill: 20%
// Supports: None needed
// Print orientation: Upright as designed