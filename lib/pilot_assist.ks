//orbit by numbers!

runoncepath("lib/calcincl").
runoncepath("lib/currincl").
runoncepath("lib/pmburn").
runoncepath("lib/mburn").
runoncepath("lib/dburn").
runoncepath("lib/calc_target_distance").
runoncepath("lib/descent").
runoncepath("lib/rocket_utils").

function pilot_assist {



  sas off.

  local ch is "".
  local pitch to pitch_for().
  local compass to compass_for().
  local launched is false.
  local thrustlimit is 100.

  until ch = "q" {

  	clearscreen.
  	print "ROCKOMAX™ PILOT ASSISTANT       :D".
    print "---------------------------------------".
  	print "0) kill       =) stage        -) UNLOCK".
  	print "1) pitch+     2) pitch-       [" + round(pitch,1) + "°]".
    print "3) limit 100  4) limiter-     [" + round(thrustlimit) + "%]".
    print "--DIRECTIONS --------------------------".
  	print "[) Prograde   ]) Retrograde   K) Up".
    print "P) Port       S) Starboard    J) Down".
    print "M) Maneuver   W) Waypoint     E) East".
    print "H) North      Y) West         U) South".
    print "T) Target     G) Target Retrograde".
    print "A) Dock Align".
    print "--PROGRAMS-----------------------------".
    print "B) PM burn    N) Mnvr burn.".
    print "D) Descent    L) DeLivery".
    print "R) Rendezvous".
    print "7) INCL diff  8) MNVR incl diff".
    print "9) Maneuver rendezvous distance".

    set ch to terminal:input:getchar().	

    if ch = "0" {
      sas off.
      lock steering to "kill".		
    }
    if ch = "U" {
      unlock throttle.
    }
    else if ch = "1" {
      set pitch to pitch_up(pitch).		
      lock steering to heading(compass,pitch).
    }
    else if ch = "2" {
      set pitch to pitch_down(pitch).		
      lock steering to heading(compass,pitch).
    }
    else if ch = "3" {
      set thrustlimit to limiter_max().    
    }
    else if ch = "4" {
      set thrustlimit to decrement_limiter().    
    }
    else if ch = "7" {
      currincl(). 
    }
    else if ch = "8" {
      calcincl(). 
    }
    else if ch = "9" {
      calc_target_distance(). 
    }
    else if ch = "=" {
      stage.		
    }
    else if ch = "J" {
      set pitch to -90.
      lock steering to heading(compass,pitch).
      heading_message("DOWN").
    }
     else if ch = "K" {
      set pitch to 90.
      lock steering to heading(compass,pitch).
      heading_message("UP").
    }
 
    else if ch = "E" {
      set compass to 90.
      lock steering to heading(compass,pitch).
      heading_message("EAST").
    }
    else if ch = "H" {
      set compass to 0.
      lock steering to heading(compass,pitch).
      heading_message("NORTH").
    }
    else if ch = "Y" {
      set compass to 270.
      lock steering to heading(compass,pitch).
      heading_message("WEST").
    }
    else if ch = "U" {
      set compass to 180.
      lock steering to heading(compass,pitch).
      heading_message("SOUTH").
    }
 
    else if ch = "[" {
      set compass to compass_for(ship, prograde).
      lock steering to prograde.    
      heading_message("PROGRADE").
    }
    else if ch = "]" {
      set compass to compass_for(ship, retrograde).
      lock steering to retrograde.    
      heading_message("RETROGRADE").
    }
    else if ch = "T" {
      if set_target_heading() {
        heading_message("TARGET").
      }
    }
    else if ch = "G" {
      if set_target_retrograde_heading() {
        heading_message("TARGET RETROGRADE").
      }
    }
    else if ch = "A" {
      if set_docking_port_target() {
        heading_message("DOCK ALIGN").
        unlock throttle.
        set throttle to 0.
      }
    }
    else if ch = "M" {
      if set_maneuver_heading() {
        heading_message("MANEUVER").
      }
    }
    else if ch = "W" {
      set compass to active_waypoint_compass(compass).
      lock steering to heading(compass, pitch_for()).
      heading_message("WAYPOINT").
    }
    else if ch = "P" {
      set compass to compass_for(ship, port_heading()).
      lock steering to port_heading().
      heading_message("PORT").
    }
    else if ch = "S" {
      set compass to compass_for(ship, starboard_heading()).
      lock steering to starboard_heading().
      heading_message("STARBOARD").
    }
    else if ch = "D" {
      descent().    
    }
    else if ch = "L" {
      descent(true).    
    }
    else if ch = "R" {
      dburn().    
    }
    else if ch = "B" {
      pmburn().    
    }
    else if ch = "N" {
      mburn().    
    }
 
  }
}


