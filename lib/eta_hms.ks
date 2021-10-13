function eta_hms {
  parameter n_eta.
  parameter round_decimals is 1.

  set hms to lexicon().
  set hms:elapsed to false.

  set hms:s to mod(n_eta, 60).
  if n_eta < 0 {
    set hms:elapsed to true.
    set n_eta to n_eta * -1.
  }
  set n_eta to (n_eta - hms:s)/60.
  set hms:m to mod(n_eta, 60).
  set hms:h to (n_eta - hms:m)/60. 
  set hms:s to round(hms:s, round_decimals).
  set hms:string to hms:h + "h, " + hms:m + "m, " + hms:s + "s".

  return hms.
}

