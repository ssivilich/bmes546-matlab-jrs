function [lst_fwd_primers, lst_rev_primers] = ...
  find_near_exonjunction(longsequence,junctionposition)
  % Find all sequences within 200 bases of the given exon junction for both
  % forward and reverse primers.
  % Prescreen them for having the right GC-structure in their first few bases.
  %
  % This function due to Jason Gilliland, Sarah Sivilich

  k = junctionposition;
  seqlen = numel(longsequence);
  maxampliconlength = 200;
  lst_fwd_primers = [];
  for i = max(k-maxampliconlength, 1):k-1
    if prefixcheck(get_fwd_primer(longsequence, i, 5))
      lst_fwd_primers(end+1) = i;
    end
  end

  lst_rev_primers = [];
  for i = k:min(k+maxampliconlength, seqlen)
    if prefixcheck(get_rev_primer(longsequence, i, 5))
      lst_rev_primers(end+1) = i;
    end
  end
end

function ok = prefixcheck(shortseq)
  % shortseq must always be a nucleotide sequence of length 5
  % Check that a primer prefix has exactly 3 GC, and that there are no runs
  % of 3 in a row.
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
