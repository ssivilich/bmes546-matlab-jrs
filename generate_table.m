function table = generate_table(primerpairs)
n_pairs = numel(primerpairs);
table = cell(n_pairs, 3);
for i = 1:n_pairs
    table(i, 1) = primerpairs(i).fwdseq;
    table(i, 2) = primerpairs(i).revseq;
    table(i, 3) = {primerpairs(i).score};
end
