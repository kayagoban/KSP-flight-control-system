
function currincl {

clearscreen.
if not hastarget {
	print "No TARGET is set.  Cannot calculate inclination difference!".
	wait 2.
	return.
}

set inclination_difference to ABS(ship:orbit:inclination - target:orbit:inclination).
if inclination_difference < 0.00001 {
	set inclination_difference to "MATCH TARGET".
}
print "Inclination difference:   " + inclination_difference.
print " ".
print "ship incl:                " + ship:orbit:inclination.
print "target incl:              " + target:orbit:inclination.


print " ".
print "Press the Any key to continue.".

set ch to terminal:input:getchar().
}
