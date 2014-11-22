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

if ~isfield(opts, 'tm_opt')
  opts.tm_opt = 59;
end

if ~isfield(opts, 'hairpin_weight')
  % Arbitrary default, just for now.
  opts.hairpin_weight = 1;
end

if ~isfield(opts, 'dimer_weight')
  % Arbitrary default, just for now.
  opts.dimer_weight = 1;
end

if ~isfield(opts, 'gc_weight')
  % Arbitrary default, just for now.
  opts.gc_weight = 0.5;
end

% Calculate oligo properties from bioinformatics toolbox
props = oligoprop(seq);

% Calculate hairpin component of score.
if numel(props.Hairpins) == 0
    n_hairpin_base = 0;
else
    n_hairpin_base = sum(lower(props.Hairpins) ~= props.Hairpins);
end
hairpin_score = n_hairpin_base * opts.hairpin_weight;

% Calculate dimer component of score
if numel(props.Dimers) == 0
    n_dimer_base = 0;
else
    n_dimer_base = sum(sum(lower(props.Dimers) ~= props.Dimers));
end
% dimer_score = n_dimer_base * opts.dimer_weight;
dimer_score = opts.dimer_weight * (n_dimer_base > 4);

% Calculate GC component of score
gc_score = abs(props.GC - 50) * opts.gc_weight;

% Calculate Tm component of score
tm_score = sum((props.Tm - opts.tm_opt).^2) * opts.tm_opt_weight;

score = hairpin_score + dimer_score + gc_score + tm_score;
end

function length = longest_hairpin(hairpin_result)
runs = regexp(hairpin_result, '[A-Z]*', 'match');
end
