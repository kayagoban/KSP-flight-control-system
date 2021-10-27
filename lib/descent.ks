
runoncepath("lib/descent_select_lz").
runoncepath("lib/descent_burn_horiz").
runoncepath("lib/descent_suicide_burn").
runoncepath("lib/descent_setdown").
runoncepath("lib/rocket_utils").


function choose_vessel {
  clearscreen.
  print "Select vessel:".
  print "--------------------".
  print "a) Munlander 4".
  print "b) Munlander 5".


  set ch to terminal:input:getchar().

  if ch = "a" {
    set VESSEL_HEIGHT to 3.69097.
    return.
  }
  else if ch = "b" {
    set VESSEL_HEIGHT to 3.0791.
    return.
  }
  

}


function descent {
  parameter delivery is false.

  set VESSEL_HEIGHT to 0.
  choose_vessel(). 

  set_engine_limits(100).

  sas off.
  gear off.
  panels off.
  lock steering to heading_retrograde_0_pitch().


  local descent_position is descent_select_lz().
  if not descent_position:result {
  	return.	
  }

  descent_burn_horiz(descent_position).
  descent_suicide_burn().
  descent_setdown(delivery).
  lock throttle to 0.
}