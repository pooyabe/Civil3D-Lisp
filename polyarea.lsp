;;POLYAREA.LSP - (c) 1997-2001 Tee Square Graphics
;;
;;  Calculates the area of one or more closed polylines and
;;  displays the result in an AutoCAD Alert Window.
;;
(defun C:POLYAREA (/ a ss n du)
  (setq a 0
        du (getvar "dimunit")
        ss (ssget '((0 . "*POLYLINE"))))
  (if ss
    (progn
      (setq n (1- (sslength ss)))
      (while (>= n 0)
        (command "_.area" "_o" (ssname ss n))
        (setq a (+ a (getvar "area"))
              n (1- n)))
      (alert
        (strcat "The total area of the selected\nobject(s) is "
                (if (or (= du 3)(= du 4)(= du 6))
;
;The following 2 lines translate the area to square inches and feet
;for users using US engineering or architectural units:
;
                  (strcat (rtos a 2 2) " square inches,\nor "
                          (rtos (/ a 144.0) 2 3) " square feet.")
;
;In the following line, change the word "units" to whatever units
;you are using - meters, millimeters, feet, etc.
;
                  (strcat (rtos a 2 3) " square units.")))))
    (alert "\nNo Polylines selected!"))
  (princ)
)