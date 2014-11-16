function score = individual_scoring(seq, opts)

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

hairpin_raw = 0 % ????
% something that counts the uppercase letters of the hairpin
% string
end
