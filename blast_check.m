function outs = blast_check(primer_seq, seq_identifier, cutoff, species)
% For a given primer sequence, perform a blast, and find the number of
% matches within the genome that are potentially troublesome.
% The supplied species is used to filter down blast results to just those that
% are of the same.
[RID, RTOE] = blastncbi(primer_seq, 'blastn');
blastdata = getblast(RID);
troublesome_hits = {};
for hit in {blastdata.Hits.Name}
    if strfind(hit, species) & ~strfind(hit, seq_identifier)
        troublesome_hits(end+1) = hit;
    end
end
end
