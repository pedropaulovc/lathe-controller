// Lathe Controller Case - 5" wide max 8" tall
// Front controls, top cable entry, with lid

// Case dimensions
case_width = 127;      // 5 inches = 127mm
case_height = 180;     // ~7 inches, under 8" limit  
case_depth = 80;       // 3.15 inches depth
wall_thickness = 3;
lid_thickness = 3;

// Control component dimensions
display_width = 50;
display_height = 19;
pot_diameter = 16;
pushbutton_diameter = 11.9;  // 32-P-970046-01 pushbuttons
estop_diameter = 22;         // Round emergency stop

// NPT 1/2 cable entry
npt_half_diameter = 21.34;   // NPT 1/2 thread diameter

module case_body() {
    difference() {
        // Main case body
        cube([case_width, case_depth, case_height]);
        
        // Internal cavity (open top for lid)
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([case_width - 2*wall_thickness, 
                  case_depth - 2*wall_thickness, 
                  case_height - wall_thickness + 1]);
    }
}

module case_lid() {
    difference() {
        // Lid base
        cube([case_width, case_depth, lid_thickness]);
        
        // NPT 1/2 cable entry hole
        translate([case_width/2, case_depth/2, -1])
            cylinder(h = lid_thickness + 2, d = npt_half_diameter);
    }
    
    // Lid lip for snug fit
    translate([wall_thickness + 1, wall_thickness + 1, -2])
        cube([case_width - 2*wall_thickness - 2, 
              case_depth - 2*wall_thickness - 2, 
              2]);
}

module front_panel_cutouts() {
    // 7-segment display cutout (top center)
    translate([case_width/2 - display_width/2, -1, case_height - 60])
        cube([display_width, wall_thickness + 2, display_height]);
    
    // Speed potentiometer (upper right)
    translate([case_width - 35, -1, case_height - 100])
        cylinder(h = wall_thickness + 2, d = pot_diameter);
    
    // Run pushbutton 32-P-970046-01 (middle left)
    translate([25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = pushbutton_diameter);
    
    // Jog pushbutton 32-P-970046-01 (middle right)
    translate([case_width - 25, -1, case_height/2 + 20])
        cylinder(h = wall_thickness + 2, d = pushbutton_diameter);
    
    // Emergency stop (lower center) - round
    translate([case_width/2, -1, 40])
        cylinder(h = wall_thickness + 2, d = estop_diameter);
}

// Side mounting tabs removed per user request

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

// Cable management moved to lid (NPT 1/2 from top)

// Main assembly
module lathe_controller_case() {
    difference() {
        union() {
            case_body();
            internal_mounts();
        }
        
        front_panel_cutouts();
    }
}

// Generate the case and lid
translate([0, 0, 0]) lathe_controller_case();
translate([case_width + 10, 0, 0]) case_lid();

// Print settings comments:
// Layer height: 0.2mm
// Infill: 20%
// Supports: None needed
// Print orientation: Case upright, lid flat