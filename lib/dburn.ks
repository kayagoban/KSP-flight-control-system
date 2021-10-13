runoncepath("lib/tsiolkovsky_burn_time").
runoncepath("lib/burn_function").
runoncepath("lib/docking").
runoncepath("lib/eta_hms").
runoncepath("lib/rocket_utils").


function rendezvous_t_minus {
  return intercept:timestamp - time:seconds - t_0.
}

function status_msg {
  

  print "Upcoming rendezvous".
  print "------------------------------" .
  print "intercept ETA:                " + eta_hms(intercept:timestamp - time:seconds,1):string.
  print "raw ETA:                      " + eta_hms(nextnode:eta):string. 
  print "distance:                     " + round(intercept:distance) + " m".
  print "relative target velocity:     " + round(deltaV, 2) + " m/s".
  print "current distance:             " + round((ship:position - target:position):mag) + " m".
  print "approach angle:               " + round(docking_approach_angle(), 2) + " degrees".
  print "burn time to cancel velocity: " + round(deltaT, 1) + " s".
  print "target retrograde:            " + target_retrograde_heading().
  print "burn ETA:                     " + eta_hms(rendezvous_t_minus(), 1):string.
}

function dburn {

  clearscreen.
  if not hastarget {
    print "No rendezvous TARGET is set!".
    wait 2.
    return.
  }

  set deltaV to docking_target_velocity().
  set deltaT to tsiolkovsky_burn_time(deltaV).
  set t_0 to deltaT/2.
  set intercept to docking_intercept().

  sas off.

  until rendezvous_t_minus() <= 3                     {
   clearscreen.
   set deltaV to docking_target_velocity().
   set deltaT to tsiolkovsky_burn_time(deltaV).
   set t_0 to deltaT/2.
   lock steering to target_retrograde_heading().
   status_msg().
   wait 1.	
 }

 //set intercept to docking_intercept().

 set deltaV to docking_target_velocity().
 set deltaT to tsiolkovsky_burn_time(deltaV).

 burn_function(rendezvous_t_minus@, deltaT, target_retrograde_heading@).

}
