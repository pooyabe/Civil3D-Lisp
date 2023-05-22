(defun c:CopyCoordinates ()
  (setq point (getpoint "\nSelect a point: "))
  (setq x-coord (car point))
  (setq y-coord (cadr point))
  (setq coords (strcat (rtos x-coord 2 6) "," (rtos y-coord 2 6)))
  
  (if (setq success (wcmatch (getvar 'platform) "*Win*"))
    (progn
      (setq clipboard (vlax-get-or-create-object "htmlfile"))
      (setq dataobj (vlax-get-property clipboard 'parentWindow))
      (setq text (vlax-get-property dataobj 'clipboardData))
      (vlax-invoke-method text 'setData "Text" coords)
      (princ "\nCoordinates copied to clipboard.")
    )
    (princ "\nClipboard operations are only supported on Windows.")
  )
  
  (princ)
)
