(seek
   (
      (ps process)
   )
   (and
      (is_explicit_process ps)
      (not
         (and
            (has_label ps)
            (string_matches [label ps] "^P_.*")
         )
      )
   )
)
