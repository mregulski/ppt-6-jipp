declare Reverse
local
   fun {ReverseHelper List Reversed}
      case List
      of nil then Reversed
      [] X|Rest then {ReverseHelper Rest X|Reversed}
      end
   end
in
   fun {Reverse List}
      {ReverseHelper List nil}
   end
end

{Browse {Reverse [1 [2 3] 4]}}