function score = individual_scoring(seq, opts)

if ~exist('seq', 'var')
    seq = 'ACGTAGAGGACGTN';
end

if ~exist('opts', 'var')
    opts = struct();
end

if ~isfield(opts, 'tm_opt_weight')
  % Arbitrary default, just for now.
  opts.tm_opt_weight = 1;
end

if ~isfield(opts, 'hairpin_weight')
  % Arbitrary default, just for now.
  opts.hairpin_weight = 1;
end

if ~isfield(opts, 'tm_opt')
  opts.tm_opt = 60;
end

score = 0;

props = oligoprop(seq);

hairpin_raw = 0; % ????
n_hairpin_base = sum(lower(props.Hairpins) ~= props.Hairpins);
score = score + n_hairpin_base * opts.hairpin_weight;

end
