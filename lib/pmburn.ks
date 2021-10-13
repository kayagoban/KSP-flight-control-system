//runoncepath("lib/burn_function_do").
//runoncepath("lib/rocket_facts").
runoncepath("lib/tsiolkovsky_burn_time").
runoncepath("lib/burn_function").


function maneuver_t_minus {
  return maneuver:eta.
}

function maneuver_burn_direction {
	return maneuver:deltav:direction.	
}

function pmburn {

  if (allnodes:length = 0) {
  	clearscreen.
  	print "No MANEUVER defined!".
  	wait 2.
  	return.
  }

  set maneuver to nextnode.
  local deltaV is maneuver:deltav:mag.
  //local deltaT is tsiolkovsky_burn_time(deltaV, false).
  local deltaT is time_from_deltaV(deltaV).

  clearscreen.
  print " ".
  print "Burn time: " + round(deltaT,2).
  print " ".
  print "c) Continue".
  print "q) Quit to main menu".

  set ch to terminal:input:getchar(). 

  until ch = "c" {
    if ch = "q" {
      return.
    } 
  }


  burn_function(maneuver_t_minus@, deltaT, maneuver_burn_direction@).

}