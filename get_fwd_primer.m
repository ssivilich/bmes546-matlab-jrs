function primer = get_fwd_primer(longseq, start, length)
    % Get a forward primer given a longseq, the start position, and the primer's
    % length.
    % This is nothing more than a thin wrapper around array indexing, but it
    % saves a lot of headaches.
    %
    % This function is due to Jason Gilliland
    primer = longseq(start:start+length-1);
end
