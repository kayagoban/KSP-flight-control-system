
function calcincl {
  if (allnodes:length = 0) {
  	clearscreen.
  	print "Cannot calculate prospective inclination without MANEUVER defined!".
  	wait 2.
  	return.
  }

  if not hastarget {
  	clearscreen.
  	print "Cannot calculate prospective inclination without TARGET defined!".
  	wait 2.
  	return.
  }

  set n to nextnode.
  
  local t is time:seconds + 60.
  from {.} until t < time:seconds step {.} do {
    set inclination_difference to ABS(n:orbit:inclination - target:orbit:inclination).
    if inclination_difference < 0.00001 {
      set inclination_difference to "MATCH TARGET".
    }
    else {
      set inclination_difference to round(inclination_difference,7).
    }
    clearscreen.
    print "Calculating for " + round(time:seconds - t) + " seconds".
    print " ".
    print "Inclination difference:   " + inclination_difference.
    print "ship incl:                " + n:orbit:inclination.
    print "target incl:              " + target:orbit:inclination.
    wait .2.
  }
}