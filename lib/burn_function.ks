runoncepath("lib/eta_hms").

function wait_screen {
  parameter burn_direction.
  parameter deltaT.

  print "- - - - - - - - - - - - - - - - -".
  print "Next maneuver at: " + hms:string.
  print " ".
  print "Burn duration:    " + round(deltaT,2) + " s".
  print " ".
  print "vector: " + burn_direction().
  print "- - - - - - - - - - - - - - - - -".
  print " ".
}


function burn_engine {
  lock throttle to 100.
}
function shutoff_engine {
  lock throttle to 0.
}

function false_func {
  return false.
}

function burn_function {
  // function delegate which returns scalar seconds until burn.
  parameter t_minus. 
  // scalar seconds magnitude of burn.
  parameter deltaT.
  // function delegate which returns the burn direction.
  parameter burn_direction.
  //optional function delegate to stop the burn. useful for zeroing out velocity, etc...
  parameter stop_function is false_func@.


  clearscreen.

  set hms to eta_hms(t_minus(), 0).
  
  if hms:elapsed {
    print "No upcoming maneuvers.".
    print " ".
    wait 2.
    return.
  }

  sas off.

  from {local t is t_minus().} until t <= 10 step {set t to t_minus().} do {
    clearscreen.
    set hms to eta_hms(t_minus(), 0).
    wait_screen(burn_direction@, deltaT).
    set steering to burn_direction().
    wait 1.
  }

  from {local t is t_minus().} until t <= 1 step {set t to t_minus().} do {
    clearscreen.
    print "Commencing burn in " + round(t_minus(), 2) + "s".
    wait 0.1.
  }

  lock steering to burn_direction().
  clearscreen.
  print "Preparing for burn...".

  local throttle_lag is 0.02.

  local start_time is 0 + throttle_lag. 

  until t_minus() <= start_time  {}

  burn_engine().

  //until t_minus() <= -deltaT  { 

  from {local t is t_minus().} until t <= -deltaT + 1.5 step {set t to t_minus().} do {
    clearscreen. 
    print "Burning engine...".
    print "vector: " + burn_direction().
    wait 1.
    lock steering to burn_direction().
  }

  clearscreen.
  print "Finishing burn...".

  local stop_time is -deltaT.

  until stop_function() or (t_minus() <= stop_time) {}

  shutoff_engine().

  lock steering to prograde.
  
  print "Finished burn.".
  wait 2.

  //unlock steering.
  //sas on.

}

 