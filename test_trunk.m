[Header, test_seq] = fastaread('homer1a.fasta');
opts.exonjunction = 1068;
[lst_fwd_primers, lst_rev_primers] = select_primers(test_seq, opts)
