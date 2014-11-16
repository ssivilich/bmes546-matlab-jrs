function [lst_primers] = find_near_exonjunction(longsequence,junctionposition)
% returns first index of junctionposition within longseqence
k = junctionposition;
% Variables containing junctionposition index + 200 NT upstream and - 200 NT
% downstream
seqlen = numel(longsequence);
maxampliconlength = 200;
lst_fwd_primers = [];
for i = max(k-maxampliconlength, 1):k-1
  if prefixcheck(longsequence(i:i+4))
    lst_fwd_primers(end+1) = i;
  end
end

revseq = seqrcomplement(longsequence);
revk = seqlen - k;
lst_rev_primers = [];
for i = max(revk-maxampliconlength, 1):revk-1
  if prefixcheck(revseq(i:i+4));
    lst_rev_primers(end+1) = i;
  end
end
end

function ok = prefixcheck(shortseq)
% shortseq must always be a nucleotide sequence of length 5
ok = true
if gc_count(shortseq) ~= 3
  ok = false
end
for start = 1:3
  if gc_count(shortseq(start:start+2)) == 3
    ok = false
  end
end
end
