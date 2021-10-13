  set ti to terminal:input.
  set response to ti.getchar().

  until false {
    print " ".
    print "Remove node?  Y/N".

    if response <> "N" {
      return.
    }
    else if response <> "Y" {
      remove n.
      return.
    } 
    else {
      print "Huh?".
       
    }
  }