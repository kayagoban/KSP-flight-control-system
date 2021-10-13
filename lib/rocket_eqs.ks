runoncepath("lib/rocket_facts").

function time_from_deltaV_with_gravity {
  parameter deltaV.
  parameter against_gravity is true.

  return (M() - M()/constant:E ^ ( (deltaV + sqrt(2*g()*deltaV))/Ve() ))/(F()/Ve()).
}

function time_from_deltaV {
  parameter deltaV.
  return ((M() * Ve()) / F()) * (1 - constant:E ^ (-deltaV/Ve())).
}

function distance_from_time {
  parameter t.
  return Ve()*(t + (M()/massrate() - t) * ln(1-massrate()*t/M())).
}

function distance_from_deltaV {
  parameter deltaV.	
  return Ve()*M()/massrate()*(1 - (1+deltaV/Ve())*constant:E^(-deltaV/Ve())).
}

