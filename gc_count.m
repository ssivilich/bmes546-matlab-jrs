function content = gc_count(sequence)
%% This function takes a sequence and returns the gc content as a fraction
  sequence = lower(sequence);
  content = sum(sequence == 'g' | sequence == 'c')/numel(sequence);
end
