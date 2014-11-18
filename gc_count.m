function content = gc_count(sequence)
%% This function takes a sequence and returns the gc content as an integer
  sequence = lower(sequence);
  content = sum(sequence == 'g' | sequence == 'c');
end
