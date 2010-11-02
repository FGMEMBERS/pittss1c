##
#  action-sim.nas   Updates various simulated features every frame
##

# Properties

var dhR_m = props.globals.getNode("gear/gear[2]/compression-m", 1);
var dhL_m = props.globals.getNode("gear/gear[1]/compression-m", 1);
var propGear1 = props.globals.getNode("gear/gear[1]", 1);
var propGear2 = props.globals.getNode("gear/gear[2]", 1);

# Associate Nodes

var left_main_rot = propGear1.getNode("compression-rotation-deg", 1);
var right_main_rot = propGear2.getNode("compression-rotation-deg", 1);

var init_actions = func {
    # Make sure that init_actions is called when the sim is reset
    setlistener("sim/signals/reset", init_actions); 

    # Request that the update fuction be called next frame
    settimer(update_actions, 0);
}


var update_actions = func {

#  Note:  R2D and FT2M  are unit conversion factors defined in $FG_ROOT/Nasal/globals.nas
#         R2D (radians to degrees) FT2M (feet to meters)

#  Compute compression induced main gear rotations
#
#  constants
   var R_m = 0.813938;
   var h0 = 0.709485;
   var theta0_rad = 0.512199;

#  Right main
   var delta_h = dhR_m.getValue();
   var right_alpha_deg = ( math.acos( (h0 - delta_h)/R_m ) - theta0_rad )*R2D;


#  Left main
   var delta_h = dhL_m.getValue();
   var left_alpha_deg = ( math.acos( (h0 - delta_h)/R_m ) - theta0_rad )*R2D;

# Outputs
    right_main_rot.setDoubleValue(right_alpha_deg);
    left_main_rot.setDoubleValue(left_alpha_deg);

    settimer(update_actions, 0);
}

# Setup listener call to start update loop once the fdm is initialized
# 
setlistener("sim/signals/fdm-initialized", init_actions); 



