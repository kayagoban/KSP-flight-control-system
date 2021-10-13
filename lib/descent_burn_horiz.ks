runoncepath("lib/burn_until").
runoncepath("lib/rocket_utils").
runoncepath("lib/navball").

runoncepath("lib/descent_horiz_burn_params").


function descent_burn_horiz {
  parameter descent_pos.

  function horiz_speed {
  	return ship:groundspeed.
  }

  function h_slower_than {
  	parameter h_speed.

    lock steering to heading_retrograde_0_pitch().
  	clearscreen.
  	print round(horiz_speed(),3) + " m/s".
    return ship:groundspeed < h_speed.
  }

  sas off. 

  lock steering to heading_retrograde_0_pitch().

  wait until time:seconds > descent_pos:t_decision + descent_pos:horiz_time_delay.

  print "acceleration:   " + ship:availablethrust / ship:mass + " m/s^2".

  set_engine_acceleration(dhb_accel_0).
  burn_until({return h_slower_than(dhb_v_f_0).}).

  set_engine_acceleration(dhb_accel_1).
  burn_until({return h_slower_than(dhb_v_f_1).}).

  set_engine_acceleration(dhb_accel_2).
  burn_until({return h_slower_than(dhb_v_f_2).}).

  set_engine_acceleration(dhb_accel_3).
  burn_until({return h_slower_than(dhb_v_f_3).}).

  //set_engine_acceleration(dhb_accel_4).
  //burn_until({return h_slower_than(dhb_v_f_4).}).
}
