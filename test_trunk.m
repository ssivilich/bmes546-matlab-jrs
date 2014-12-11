% Since 'select_primers' is our 'trunk' function, where most of the action
% happens, this script is merely meant to test it's functionality in a
% fairly basic way, allowing the developer to manually inspect the results.
[Header, test_seq] = fastaread('homer1a.fasta');
opts.exonjunction = 1068;
primerpairs = select_primers(test_seq, opts);
fnameout = 'report.fasta';
generate_report(fnameout, primerpairs);
