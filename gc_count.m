function content = gc_count(sequence)
  %% This function takes a sequence and returns the gc content as an integer
  %
  % This function due to Sarah Sivilich
  sequence = lower(sequence);
  content = sum(sequence == 'g' | sequence == 'c');
end
