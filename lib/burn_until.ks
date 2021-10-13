
function burn_until {
  parameter shutoff_fn.

  lock throttle to 100.	
  print "burning...".
  wait until shutoff_fn(). 
  lock throttle to 0.
}