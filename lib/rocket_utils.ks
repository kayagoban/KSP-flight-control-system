runoncepath("lib/rocket_facts").
runoncepath("lib/navball").

function pitch_up {
  parameter pitch.

  set pitch to pitch + 15.
  if pitch > 90 {
    set pitch to 90.
  }
  return pitch.
}

function pitch_down {
  parameter pitch.

  set pitch to pitch - 15.
  if pitch < 0 {
    set pitch to 0.
  }
  return pitch.
}

function limiter_max {
  return set_engine_limits(100).
}

// reduces limiter by 10.
function decrement_limiter {
  return set_engine_limits(0, true).
}

function set_engine_limits {
  parameter tlimit is 100.
  parameter decrement is false.
	parameter verbose is false.

  list engines in enginelist.
  for engine in enginelist {
    if engine:ignition { 
      if decrement {
        set engine:thrustlimit to engine:thrustlimit - 10.
      }
      else {
        set engine:thrustlimit to tlimit.
      }
      if verbose {
        print engine:title + " " + engine:thrust + " " + engine:thrustlimit.
      }
    }
  }
  return enginelist[0]:thrustlimit.
}

function set_engine_acceleration {
  parameter accel.

  local tlimit is accel * ship:mass / ship:maxthrust * 100.
  if tlimit > 100 {
    set tlimit to 100.
  }
  set_engine_limits(tlimit).
}

function set_equality_limits {
  set_engine_limits(g()/(F()/M()) * 100).
}

function heading_message {
  parameter msg.
  clearscreen.
  print "New heading: " + msg.
  wait 2.
}

function heading_error_message {
  parameter msg is "Cannot change heading".
  clearscreen.
  print "ERROR! " + msg.
  wait 2.
}

function heading_prograde_0_pitch {
  return heading(compass_for(ship, prograde), 0).
}

function heading_retrograde_0_pitch {
  return heading(compass_for(ship, -ship:velocity:surface), 0).
}

function retrograde_yaw {
  return r(ship:facing:pitch, retrograde:yaw, ship:facing:roll).
}

function active_waypoint_compass {
  parameter compass.

  local selected is list(). 
  local wps is allwaypoints().
  for x in wps {
    if x:isselected {
      selected:add(x).
    }
  }
  if selected:length < 1 {
    heading_message("No waypoint is selected!").
    return compass.
  }
  return compass_for(ship, selected[0]:position).
  //lock steering to heading(compass, 0).
  
}

function set_target_heading {
  if hastarget {
    set compass to compass_for(ship, target:position).
    lock steering to heading(compass, 0).
    RETURN TRUE.
  }
  else {
    clearscreen.
    print "ERROR! NO TARGET".
    wait 2.
    return FALSE.
  } 
}

function set_maneuver_heading {
  if (allnodes:length = 0) {
    clearscreen.
    print "No MANEUVER defined!".
    wait 2.
    return FALSE.
  }  
  else {
    lock steering to maneuver_heading().
    return TRUE.
  }
}

function maneuver_heading {
  if (allnodes:length > 0) {
    return nextnode:deltav:direction.
  }  
  return prograde.
}

function set_target_retrograde_heading {
  if hastarget {
    lock steering to target_retrograde_heading().
    RETURN TRUE.
  }
  else {
    clearscreen.
    print "ERROR! NO TARGET".
    wait 2.
    return FALSE.
  } 
}

function target_retrograde_heading {
  if hastarget {
    return (target:velocity:orbit - ship:velocity:orbit).
  }
  return prograde.
}

function set_docking_port_target {
  if hastarget {
    lock steering to docking_port_heading().
    RETURN TRUE.
  }
  else {
    clearscreen.
    print "ERROR! NO TARGET".
    wait 2.
    return FALSE.
  } 
}

function docking_port_heading {
  if hastarget {
    return -target:portfacing:forevector.
  }
  return prograde.
}

function target_heading {
  return heading(compass_for(ship, target:position), 0).
}

function port_heading {
  return VCRS(SHIP:BODY:POSITION,SHIP:VELOCITY:ORBIT).
}

function starboard_heading {
  return -VCRS(SHIP:BODY:POSITION,SHIP:VELOCITY:ORBIT).
}

function docking_target_prograde {
  return ship:velocity:orbit - target:velocity:orbit.
}

function docking_approach_angle {
  return vectorAngle(target:velocity:orbit, ship:velocity:orbit).
}

function docking_target_velocity {
  return target_retrograde_heading():mag.
}

