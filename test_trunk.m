[Header, test_seq] = fastaread('homer1a.fasta');
opts.exonjunction = 1068;
primerpairs = select_primers(test_seq, opts);
fnameout = 'report.fasta';
generate_report(fnameout, primerpairs);
