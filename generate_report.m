function generate_report(fname, primerpairs)
fid = fopen(fname, 'w');
for i_pair = 1:numel(primerpairs)
    fwdseq_string = primerpairs(i_pair).fwdseq;
    revseq_string = primerpairs(i_pair).revseq;
    % disp(fwdseq_string);
    % disp(revseq_string);
    fprintf(fid, '>fwd primer sequence: %d, score: %f\n', i_pair, ...
        primerpairs(i_pair).score);
    fprintf(fid, '%s\n', fwdseq_string{:});
    fprintf(fid, '>rev primer sequence: %d, score: %f\n', i_pair, ...
        primerpairs(i_pair).score);
    fprintf(fid, '%s\n', revseq_string{:});
end

fclose(fid);
