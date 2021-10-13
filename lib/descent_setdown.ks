runoncepath("lib/burn_until").
runoncepath("lib/rocket_utils").

function descent_setdown {
  parameter delivery is false.
  
  function geo_height {
    return SHIP:GEOPOSITION:TERRAINHEIGHT.
  }

  function geo_altitude {
    return ship:altitude - geo_height().
  }  

  function second_burn_distance_reached {
    lock steering to ship:srfretrograde.
    return alt:radar < VESSEL_HEIGHT + 5.
  }

  function delivery_range {
    lock steering to ship:srfretrograde.
    return alt:radar < VESSEL_HEIGHT + 2.
  }

  function in_setdown_range { 
    lock steering to ship:srfretrograde.
    return alt:radar < VESSEL_HEIGHT + 0.5.
  }

  //set_equality_limits().
  //burn_until(second_burn_distance_reached@).
  //lock steering to heading(90, 90).
  //set_engine_limits(100). 
  //local end_burn is (time:seconds + time_from_deltaV(12)).
  //burn_until({ return time:seconds > end_burn.}). 

  //lock steering to heading(90, 90).
  set_equality_limits().

  if delivery {
    burn_until(delivery_range@).
    lock throttle to 0.
    return.
  } else { 
    burn_until(in_setdown_range@).
    lock throttle to 0.
    ON (ship:velocity:surface:mag < 0.01) {
      panels on.
    }
  }
  set_engine_limits(100). 
  unlock throttle.
  unlock steering.
}