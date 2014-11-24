function primer = get_rev_primer(longseq, start, length)
primer = seqrcomplement(longseq(start-length+1:start));
end
