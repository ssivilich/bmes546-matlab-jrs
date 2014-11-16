%% Test the blast_check function
seq_identifier = 'NM_004272.4'
primer_seq = 'GCAACATATACCAAGTCAC'
species = 'Homo sapiens'
RID = '6CXYD2P301R'
n_trouble = blast_check(primer_seq, seq_identifier, species, RID)
