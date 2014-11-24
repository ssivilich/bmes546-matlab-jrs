function primer = get_fwd_primer(longseq, start, length)
primer = longseq(start:start+length-1);
end
