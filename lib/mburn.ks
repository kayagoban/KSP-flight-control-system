runoncepath("lib/tsiolkovsky_burn_time").
runoncepath("lib/burn_function").
runoncepath("lib/rocket_utils").


//function t_minus {
//  return nextnode:eta - t_0.
//}

function mburn {
  local throttle_lag is 0.
  local deltat is tsiolkovsky_burn_time(nextnode:deltav:mag).
  local t_0 is deltat / 2 + throttle_lag.
  wait 5.
  burn_function({return nextnode:eta - t_0.}, deltaT, maneuver_heading@).
}