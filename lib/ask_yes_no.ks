  set ti to terminal:input.
  set response to ti.getchar().

  until false {
    print " ".
    print "Remove node?  Y/N".

    if response <> "N" {
      break.
    }
    else if response <> "Y" {
      remove n.
      break.
    } 
    else {
      print "Huh?".
       
    }
  }