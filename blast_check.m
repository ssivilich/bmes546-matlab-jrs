function n_trouble = blast_check(primer_seq, seq_identifier, species, ...
RID)
% For a given primer sequence, perform a blast, and find the number of
% matches within the genome that are potentially troublesome.
% The supplied species is used to filter down blast results to just those that
% are of the same.
if ~exist('RID', 'var')
    [RID, RTOE] = blastncbi(primer_seq, 'blastn');
    disp(RID)
end
try
    blastdata = getblast(RID);
catch err
    [RID, RTOE] = blastncbi(primer_seq, 'blastn');
    blastdata = getblast(RID);
end
troublesome_hits = {};
for hit = blastdata.Hits
    if hiteval(hit)
        troublesome_hits(end+1) = hit;
    end
end
n_trouble = numel(troublesome_hits);
end

function istrouble = hiteval(hit)
hitname = hit.Name;
istrouble = false;
if strfind(hitname, species) & ...
        ~strfind(hitname, seq_identifier) & ...
        strfind(hitname, 'NM')
    istrouble = true;
end
end
