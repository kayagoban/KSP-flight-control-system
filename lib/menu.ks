
runoncepath("lib/calcincl").
runoncepath("lib/currincl").
runoncepath("lib/pmburn").
runoncepath("lib/dburn").
runoncepath("lib/pilot_assist").
runoncepath("lib/calc_target_distance").

function bootfun {

  //print "Press the Any key to boot.".
  //set ch to terminal:input:getchar().
  clearscreen.
  wait 2.
  print "TRSH-KN 8068 16mhz".
  wait 1.
  print "Loading RAM...".
  wait 1.

  from {local ram is 4.} until ram > 256 step {set ram to ram * 2.} do {
  	clearscreen.
    print "TRSH-KN 8068 16mhz".
    print ram + " kB RAM loaded".
    wait 1.5.
  }

  clearscreen.
  print "Loading TRS OS".
  wait 2.

}

function menu {
  
  //bootfun().
  pilot_assist().
}



function old_menu {

  until false {

    clearscreen.
    print "".
    print "MENU".
    print "---------".
    print " ".
    print "1) Burn maneuver".
    print "2) Rendezvous slowdown burn".
    print "3) Show current inclination difference from target.".
    print "4) Show target inclination difference for maneuver".
    print "5) Show rendezvous intercept distance for maneuver".
    print "6) ROCKOMAX™ pilot assistant".

    set ch to terminal:input:getchar().

    if ch = "1" {
    	pmburn().
    }
    else if ch = "2" {
    	dburn().
    }
    else if ch = "3" {
    	currincl().
    }
    else if ch = "4" {
    	calcincl().
    }
    else if ch = "5" {
    	calc_target_distance().
    }
    else if ch = "6" {
      pilot_assist().
    }
  }

}
