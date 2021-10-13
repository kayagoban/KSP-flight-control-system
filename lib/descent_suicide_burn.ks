runoncepath("lib/burn_until").
runoncepath("lib/rocket_facts").

function descent_suicide_burn {

  function vertical_speed_slowed {
    lock steering to ship:srfretrograde. 
    //lock steering to heading(90, 90). //
    return vertical_speed() < 8. 
  }

  function it_is_almost_too_late {
    clearscreen.
    //print "geo_altitude:           " + geo_altitude().
    print "alt:radar:              " + alt:radar.
    //print "ship:altitude           " + ship:altitude.
    //print "SHIP:GEOPOSITION:TERRAINHEIGHT   " + SHIP:GEOPOSITION:TERRAINHEIGHT.
    print "distance to zero speed: " + distance_from_time(time_from_deltav_with_gravity(vertical_speed())).
    //print "geoalt + dist buffer:   " + (geo_altitude() - distance_buffer).
    return distance_from_time(time_from_deltav_with_gravity(vertical_speed())) > (alt:radar - distance_buffer).
    //return distance_from_time(time_from_deltav_with_gravity(vertical_speed())) > (geo_altitude() - distance_buffer).
  }
 
  gear on.
  local distance_buffer is VESSEL_HEIGHT + 0.
  set_engine_limits(100).
  lock steering to heading(90, 90).
  wait until it_is_almost_too_late().
  print ( distance_from_time(time_from_deltav_with_gravity(vertical_speed())) > (geo_altitude() - distance_buffer) ).
  burn_until(vertical_speed_slowed@).


} 
