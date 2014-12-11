function primer = get_rev_primer(longseq, start, length)
    % Get a reverse primer given a longseq, the start position, and the
    % primer's length.
    % Just like it's twin that does forward primers this is nothing more
    % than a thin wrapper around array indexing, but it saves a lot of
    % headaches: probably a lot more headaches than its forward variant.
    %
    % This function is due to Jason Gilliland
    primer = seqrcomplement(longseq(start-length+1:start));
end
