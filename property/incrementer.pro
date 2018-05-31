(seek
   (
      (wf waveform)
      (ps process)
   )
   (CTL_verifies ps
      (EF
         (and
            (is_read_structure "(???)")
            (is_read_element "0" "+")
            (is_read_element _ wf)
            (is_read_element _ "L")
         )
      )
   )
)
