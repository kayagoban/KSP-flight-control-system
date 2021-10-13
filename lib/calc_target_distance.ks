runoncepath("lib/docking").

function calc_target_distance {
 
  local t is time:seconds + 45.
  from {.} until t < time:seconds step {.} do {
    local intercept is docking_intercept().
    clearscreen.
    print "Calculating for " + round(time:seconds - t) + " seconds".
    print " ".
    print "Rendezvous distance:   " + intercept:distance + " m".
    print "Relative velocity:   " +  intercept:velocity + " m/s".
    wait .2.
  }
}