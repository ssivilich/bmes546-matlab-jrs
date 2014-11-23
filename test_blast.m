%% Test the blast_check function
seq_identifier = 'NM_004272.4'
% primer_seq = 'GCAACATATACCAAGTCAC'
% species = 'Homo sapiens'
% RID = '6ZG4NN5B01R'
% n_trouble = blast_check(primer_seq, seq_identifier, species, RID)

[Header, test_seq] = fastaread('homer1a.fasta');
if ~exist('RID', 'var')
    [RID, RTOE] = blastncbi(test_seq, 'blastn');
    disp(RID);
end
blastdata = getblast(RID);
