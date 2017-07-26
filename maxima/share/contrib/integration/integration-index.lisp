(in-package :cl-info)
(let (
(deffn-defvr-pairs '(
; CONTENT: (<INDEX TOPIC> . (<FILENAME> <BYTE OFFSET> <LENGTH IN CHARACTERS> <NODE NAME>))
("conditional_integrate" . ("abs_integrate.info" 9906 889 "Definitions for abs_integrate"))
("convert_to_signum" . ("abs_integrate.info" 10796 673 "Definitions for abs_integrate"))
("extra_definite_integration_methods" . ("abs_integrate.info" 5925 1135 "Definitions for abs_integrate"))
("extra_integration_methods" . ("abs_integrate.info" 3701 2223 "Definitions for abs_integrate"))
("intfudu" . ("abs_integrate.info" 7061 1550 "Definitions for abs_integrate"))
("intfugudu" . ("abs_integrate.info" 8612 834 "Definitions for abs_integrate"))
("signum_to_abs" . ("abs_integrate.info" 9447 458 "Definitions for abs_integrate"))
))
(section-pairs '(
; CONTENT: (<NODE NAME> . (<FILENAME> <BYTE OFFSET> <LENGTH IN CHARACTERS>))
("Definitions for abs_integrate" . ("abs_integrate.info" 3633 7836))
("Introduction to abs_integrate" . ("abs_integrate.info" 489 2994))
)))
(load-info-hashtables (maxima::maxima-load-pathname-directory) deffn-defvr-pairs section-pairs))
