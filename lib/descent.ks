
runoncepath("lib/descent_select_lz").
runoncepath("lib/descent_burn_horiz").
runoncepath("lib/descent_suicide_burn").
runoncepath("lib/descent_setdown").
runoncepath("lib/rocket_utils").


function choose_vessel {
  clearscreen.
  print "Select vessel:".
  print "--------------------".
  print "1) Moon lander probe".
  print "4) Science lander 4".
  print "5) Science lander 5".
  print "6) Science lander 6".
  print "8) Refinery / Tanker".
  print "9) Lightbulb rescue lander".
  print "E) Engineering Delivery".
  print "U) Utility shuttle".
  print "P) Package delivery lander"  .

  set ch to terminal:input:getchar().

  if ch = "1" {
    set VESSEL_HEIGHT to 1.8837.
    return.
  }
  else if ch = "4" {
    set VESSEL_HEIGHT to 2.79898.
    return.
  }
  else if ch = "5" {
    set VESSEL_HEIGHT to 2.7464.
    return.
  }
  else if ch = "8" {
    set VESSEL_HEIGHT to 20.0344.
    return.
  }
  else if ch = "9" {
    set VESSEL_HEIGHT to 3.784.
    return.
  }
  else if ch = "e" {
    set VESSEL_HEIGHT to 1.9918.
    return.
  }
  else if ch = "u" {
    set VESSEL_HEIGHT to 2.908.
    return.
  }
  else if ch = "p" {
    set VESSEL_HEIGHT to 0.799285.
    return.
  }
  else if ch = "6" {
    set VESSEL_HEIGHT to 2.52389.
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