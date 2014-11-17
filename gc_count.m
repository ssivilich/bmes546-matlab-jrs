function content = gc_count(sequence)
%% This function takes a sequence and returns the gc content as a fraction

%what does the lower(sequence) mean?  Is that an index of sequence?
  sequence = lower(sequence);
  content = sum(sequence == 'g' | sequence == 'c')/numel(sequence);
end
