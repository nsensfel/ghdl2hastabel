#require "simple_flip_flop"
#require "async_reset_flip_flop"

(seek
   (
      (reg waveform)
      (clk waveform)
      (ps process)
   )
   (and
      (not (eq reg clk))
;;      (is_accessed_by reg ps)
;;      (is_accessed_by clk ps)
      (or
         (simple_flip_flop reg clk ps)
         (async_reset_flip_flop reg clk _ ps)
      )
   )
)
