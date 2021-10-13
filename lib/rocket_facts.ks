//Ve is not cumulative over many engines.
// what if we have multiple engines with differing isp?  dunno.
function Ve {
  list engines in engineList.
  for engine in enginelist {
    if engine:ignition { 
      return (engine:isp * constant:g0).
    }
  }
  print "!!! CANNOT CALCULATE Ve; NO ACTIVE ENGINES!!!".
  wait until false.
}


function M {
  return ship:mass * 1000.
}

function F {
  return ship:availablethrust * 1000.
}

function g {
  return (body:mu / (altitude + body:radius)^2).
}

function massrate {
  local massrate_ is 0.
  list engines in engineList.
  for engine in enginelist {
    if engine:ignition { 
      set massrate_ to massrate_ +  engine:maxmassflow.
    }
  }
  if massrate_ = 0 {
    print "!!! CANNOT CALCULATE MassRate; NO ACTIVE ENGINES".
    wait until false.
  }
  return massrate_ * 1000.
}

function geo_altitude {
  return ship:altitude - SHIP:GEOPOSITION:TERRAINHEIGHT.
}  

function vertical_speed {
  return ABS(vdot(ship:velocity:surface, up:forevector)).
}