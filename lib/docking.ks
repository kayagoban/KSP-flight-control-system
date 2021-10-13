
function docking_intercept {
   if (allnodes:length = 0) {
    clearscreen.
    print "Cannot calculate without MANEUVER defined!".
    wait 2.
    return.
  }

  if not hastarget {
    clearscreen.
    print "Cannot calculate without TARGET defined!".
    wait 2.
    return.
  }

  local rendezvous_node is nextnode.
  local intercept is lexicon().
  local timestamp is TIME:seconds + rendezvous_node:ETA.
  //intercept:add("timestamp", timestamp).
  local ship_pos is positionat(ship, timestamp).
  local target_pos is positionat(target, timestamp).
  intercept:add("timestamp", timestamp).
  intercept:add("distance",round((ship_pos - target_pos):mag)).
  local ship_vel is velocityat(ship, timestamp):orbit.
  local target_vel is velocityat(target, timestamp):orbit.
  intercept:add("velocity", round((ship_vel - target_vel):mag)).

  return intercept.
}
