function generate_report(fname, primerpairs)
    % Generate a FASTA formatted report from a given structure of
    % primerpairs at the specified filename.
    %
    % This function due to Jason Gilliland, Reham Garash
    fid = fopen(fname, 'w');
    for i_pair = 1:numel(primerpairs)
        fwdseq_string = primerpairs(i_pair).fwdseq;
        revseq_string = primerpairs(i_pair).revseq;
        fprintf(fid, '>fwd primer sequence: %d, score: %f\n', i_pair, ...
            primerpairs(i_pair).score);
        fprintf(fid, '%s\n', fwdseq_string{:});
        fprintf(fid, '>rev primer sequence: %d, score: %f\n', i_pair, ...
            primerpairs(i_pair).score);
        fprintf(fid, '%s\n', revseq_string{:});
    end

fclose(fid);
