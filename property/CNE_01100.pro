(seek
   (
      (pt port)
   )
   (not
      (or
         (and
            (string_matches [identifier pt] "^i_.*")
            (has_mode pt "in")
         )
         (and
            (string_matches [identifier pt] "^o_.*")
            (has_mode pt "out")
         )
         (and
            (string_matches [identifier pt] "^b_.*")
            (has_mode pt "inout")
         )
      )
   )
)
