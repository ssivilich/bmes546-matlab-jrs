function t_match = primer_t_match(seq1, seq2, tolerance, salt_content)
% Given 2 sequences (primers), determine whether their melting points are
% within a given tolerance.
t_1 = melting_point(seq1, salt_content)
t_2 = melting_point(seq2, salt_content)
if abs(t_1 - t_2) < tolerance
  t_match=true
else
  t-match= false
end
end
