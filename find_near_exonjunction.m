function [lst_fwd_primers, lst_rev_primers] = ...
  find_near_exonjunction(longsequence,junctionposition)
k = junctionposition;
seqlen = numel(longsequence);
maxampliconlength = 200;
lst_fwd_primers = [];
for i = max(k-maxampliconlength, 1):k-1
  % if prefixcheck(longsequence(i:i+4))
  if prefixcheck(get_fwd_primer(longsequence, i, 5))
    lst_fwd_primers(end+1) = i;
  end
end

% revseq = seqrcomplement(longsequence);
% revk = seqlen - k;
lst_rev_primers = [];
for i = k:min(k+maxampliconlength, seqlen)
  % if prefixcheck(revseq(i:i+4));
  if prefixcheck(get_rev_primer(longsequence, i, 5))
    lst_rev_primers(end+1) = i;
  end
end
end

function ok = prefixcheck(shortseq)
% shortseq must always be a nucleotide sequence of length 5
ok = true;
if gc_count(shortseq) ~= 3
  ok = false;
end
for start = 1:3
  if gc_count(shortseq(start:start+2)) == 3
    ok = false;
  end
end
end
