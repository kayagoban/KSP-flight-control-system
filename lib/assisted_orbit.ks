//orbit by numbers!


function launch {	
  lock throttle to 100.
  lock steering to heading(90,90).
  stage.
}

function pitch_up {
  lock steering to heading(90,pitch()+15).
}

function pitch_down {
  lock steering to heading(90,pitch()-15).
}

function preflight {
  set current_pitch to 90.
  set heading_east to 90.
  lock steering to heading(east, current_pitch).
}

function pitch {
	return (90 - VANG(ship:facing:vec, ship:up)).
}

function pilot_assistant {
  local ch is "".
  local pitch is 0.
  local launched is false.

  until ch = "q" {

  	print "ROCKOMAX™ PILOT ASSISTANT       :D".
  	print "-------------------------".
  	print "HEADING:      " + HEADING + "°".
  	print "PITCH:        " + pitch + "°".

  	if not launched {
  	  print "0)launch".
  	}

  	print "1)pitch-up        2)pitch-down".
  	print "3)full-throttle   4)cut-throttle".
  	print "5)face-prograde   6)face-retrograde".
  	print "9)stage           q)quit-to-menu".

    set ch to terminal:input:getchar().	

    if not launched {
	    if ch = "0" {
	      preflight().		
	    }
	    set launched to true.
	}
    else if ch = "1" {
      pitchup().		
    }
    else if ch = "2" {
      pitchdown().		
    }
    else if ch = "3" {
      fullthrottle().		
    }
    else if ch = "4" {
      cutthrottle().		
    }
    else if ch = "5" {
      faceprograde().		
    }
    else if ch = "6" {
      faceretrograde().		
    }
    else if ch = "9" {
      stage.		
    }
    else if ch = "q" {
      break.		
    }
 
  }

}


