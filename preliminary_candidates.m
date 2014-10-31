function inds = preliminary_candidates(long_sequence, exon_location, ...
max_distance, opts)
% Given a long mRNA sequence, and the index of an exon boundary, find indices
% of potential sites within the sequence at which sensible primers might
% start.
% These sites may be identified by the fact that they have exactly 3 out of
% their first 5 nucleotides as either G or C.

% within_range = longsequence(exon_location-max_distance:exon_location);
inds = [];
for i_pos = exon_location - max_distance:max_distance - 5
    cand_seq = long_sequence(i_pos:i_pos+4);
    if gc_count(cand_seq) == 3
        inds(end+1) = i_pos;
    end
end
end
