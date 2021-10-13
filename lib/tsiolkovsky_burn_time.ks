function tsiolkovsky_burn_time {

  function print_stats {
    clearscreen.
    print "Burn data".
    print "---".
    print "ship mass: " + round(M,3) + " tn".
    print "Ve:        " + round(Ve,3) + " m/s".
    print "deltaV:    " + round(deltaV,3) + " m/s".
    print "engines:   ".
    for e in activeEngines {
      print "   " + e:title.
      print "   limiter:  " + round(e:thrustLimit) + "%" + "   maxthrust: " + round(e:maxthrust) + "kN".
    }
    print "thrust:    " + round(F) + "kN".
    print "---".
    //print "deltaT:  " + round(deltaT, 3) + " s".
    print "Press the Any key to continue.".

    terminal:input:getchar().
  }


  parameter deltaV.
  parameter printStats is false.


  local specificImpulse is 0. 
  local F is 0.

  local engineList is list().

  list engines in engineList.

  local activeEngines is list() . 
  for engine in enginelist {
    if engine:ignition { 
      set specificImpulse to specificImpulse + engine:isp. 
      set F to F + engine:maxthrust * (engine:thrustlimit * 0.01).
      activeEngines:add(engine).
    }
  }
  local M is ship:mass.
  //local F is ship:maxthrust * (thrustlimit / 100).
  local referenceGravitation is constant:g0.
  local Ve is specificImpulse * referenceGravitation.
  //set deltaV to maneuver:deltav:mag.

  if printstats {
    print_stats().
  }

  // Tsiolkovsky's rocket equation solved for deltaT.
  return ((M * Ve) / F) * (1 - constant:E ^ (-deltaV/Ve)).

}


