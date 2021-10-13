runoncepath("lib/rocket_eqs").
runoncepath("lib/descent_horiz_burn_params").
runoncepath("lib/rocket_utils").

function descent_select_lz {

  function stop_t {
    //return h_cancel:deltaD/h_cancel:h_velocity.
    //return (h_cancel:deltaT + h_cancel:deltaD/h_cancel:h_velocity) / 2 .
    return h_cancel:deltaD/h_cancel:h_velocity.
  }

  function draw_selected_vector {
  	set drawLz to vecdraw(v_selection@, { return body:position.}, blue, "future position", 0.3, true ).
  }

  function v_b0 {
  	return positionat( ship, time:seconds + horiz_time_delay ).
  }

  function v_lz {
    return positionat( ship, time:seconds + horiz_time_delay + abs(stop_t()) ).
  }

  function v_selection {
  	return positionat( ship, t_decision + horiz_time_delay + abs(stop_t()) ).
  }

  function update_stats {
  	//find horizontal vector
  	local h_velocity is ABS(ship:velocity:surface * ship:retrograde:forevector).


  	//find time to cancel the velocity
    local deltaT is time_from_deltaV(h_velocity).
    local deltaD is distance_from_deltav(h_velocity).



    set_engine_acceleration(dhb_accel_1).
    local dd_1 is distance_from_deltav(h_velocity - dhb_v_f_1).
    local dt_1 is time_from_deltav(h_velocity - dhb_v_f_1).
    set_engine_acceleration(dhb_accel_2).
    local dd_2 is distance_from_deltav(dhb_v_f_1 - dhb_v_f_2).
    local dt_2 is time_from_deltav(dhb_v_f_1 - dhb_v_f_2).
    set_engine_acceleration(dhb_accel_3).
    local dd_3 is distance_from_deltav(dhb_v_f_2 - dhb_v_f_3).
    local dt_3 is time_from_deltav(dhb_v_f_2 - dhb_v_f_3).
    set_engine_acceleration(dhb_accel_4).
    local dd_4 is distance_from_deltav(dhb_v_f_3 - dhb_v_f_4).
    local dt_4 is time_from_deltav(dhb_v_f_3 - dhb_v_f_4).
    set_engine_limits(100).

  	local h_cancel is lexicon().
  	h_cancel:add("h_velocity", h_velocity).
    h_cancel:add("deltaT", deltaT).
    h_cancel:add("deltaD", deltaD).
    h_cancel:add("cumulativeDD", (dd_1 + dd_2 + dd_3 + dd_4)).
    h_cancel:add("cumulativeDT", (dt_1 + dt_2 + dt_3 + dt_4)).
  	return h_cancel.
  }

  local h_cancel is update_stats().
  local horiz_time_delay is 0.5.
  local htime_increment is 5.
  local throttle_increment is 0.
  lock throttle to throttle_increment.

  //local drawB0 is vecdraw(v_b0@, {return body:position.}, green, "future position", 0.3, true).
  //local drawLz is vecdraw(v_lz@, {return body:position.}, rgb(0.6, 1, 0.6), "future position", 0.3, true).
  local drawLz is vecdraw(v_lz@, {return body:position.}, rgb(0.6, 1, 0.6), "future position", 0.3, true).

  until false {
  	local h_cancel is update_stats().
  	clearscreen.
    print "ROCKOMAX™ IMPACT SCHEDULER   ".
    print "-------------------------------------".
    print " ".
  	//print "Horiz time delay:            " + horiz_time_delay.
  	//print "Horiz time delay increment:  " + htime_increment.
    //print " ".
  	//print "s) nearer".
  	//print "w) further".
  	//print "a) finer".
  	//print "d) coarser".
    print "[) Port".
    print "]) Starboard".
    print "\) Retrograde".
    print "P) Up".
    print ".) Increment throttle".
    print "/) Cut throttle.".
    print " ".
    print "-----------------------------------".
    print "B) Begin descent at chosen location".
  	print "q) Abort and quit to menu".
    print "-----------------------------------".
    print " ".
    print "(rockomax is not reponsible for rapid".
    print "unscheduled disassembly of spacecraft".
    print "and personnel.)".

  	local ch is terminal:input:getchar().

  	//if ch = "w" {
  	//  set horiz_time_delay to horiz_time_delay + htime_increment.
  	//}
  	//if ch = "s" {
  	//  if not (horiz_time_delay <= 0.5) {
  	//    set horiz_time_delay to horiz_time_delay - htime_increment.
  	//  } 
  	//}
  	//if ch = "a" {
    //  if not (htime_increment < 2) {
  	//    set htime_increment to htime_increment - 1.
  	//  }
  	//}
  	//if ch = "d" {
  	//  set htime_increment to htime_increment + 1.
  	//}

    if ch = "." {
      if not (throttle_increment > 98) {
        set throttle_increment to throttle_increment + 0.02.
      }
    }
 
    if ch = "/" {
      set throttle_increment to 0.
    }

    if ch = "[" {
      lock steering to port_heading().
    }
      
    if ch = "]" {
      lock steering to starboard_heading().
    }
    
    if ch = "\" {
      lock steering to retrograde.   
    }

    if ch = "P" {
      lock steering to up.   
    }
 
  	if ch = "b" {
  	  // the time of decision is the critical variable
  	  set t_decision to time:seconds.
      set t_orbit to ship:orbit.
      h_cancel:add("t_decision", t_decision).
      h_cancel:add("horiz_time_delay", horiz_time_delay).
      h_cancel:add("result", true).
      CLEARVECDRAWS().
  	  //draw_selected_vector().
  	  //burn_horizontal().
  	  return h_cancel.
  	}

  	if ch = "q" {
      h_cancel:add("result", false).
      CLEARVECDRAWS().
  	  return h_cancel.
  	}
  }
}



