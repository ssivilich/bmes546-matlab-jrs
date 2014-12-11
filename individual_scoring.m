function score = individual_scoring(seq, opts)
% Come up with a numerical score for an individual primer given a sequence
% based on a number of factors, including GC-content, dimerization,
% hairpinning, presence of AT-tail, melting temperature, etc.
% The scores are higher where the primer is the poorer, as in golf.
% The weights of each feature can be manipulated with the fields of the
% "opts" argument.

  if ~exist('seq', 'var')
      seq = 'ACGTAGAGGACGTN';
  end

  %% set default options
  if ~exist('opts', 'var')
      opts = struct();
  end

  if ~isfield(opts, 'tm_opt_weight')
    opts.tm_opt_weight = 0.5;
  end

  if ~isfield(opts, 'tm_opt')
    opts.tm_opt = 59;
  end

  if ~isfield(opts, 'hairpin_weight')
    opts.hairpin_weight = 1;
  end

  if ~isfield(opts, 'dimer_weight')
    opts.dimer_weight = 1;
  end

  if ~isfield(opts, 'gc_weight')
    opts.gc_weight = 0.5;
  end

  if ~isfield(opts, 'at_tail_weight')
    opts.at_tail_weight = 0.5;
  end

  %% Calculate oligo properties from bioinformatics toolbox
  props = oligoprop(seq);

  %% Calculate hairpin component of score.
  if numel(props.Hairpins) == 0
      n_hairpin_base = 0;
  else
      n_hairpin_base = sum(sum(lower(props.Hairpins) ~= props.Hairpins));
  end
  hairpin_score = n_hairpin_base * opts.hairpin_weight;

  %% Calculate dimer component of score
  if numel(props.Dimers) == 0
      n_dimer_base = 0;
  else
      n_dimer_base = sum(sum(lower(props.Dimers) ~= props.Dimers));
  end
  dimer_score = opts.dimer_weight * (n_dimer_base > 4);

  %% Calculate GC component of score
  gc_score = abs(props.GC - 50) * opts.gc_weight;

  %% Calculate Tm component of score
  tm_score = sum((props.Tm - opts.tm_opt)) * opts.tm_opt_weight;

  %% Calculate AT tail component of score
  at_score = at_tail_score(seq) * opts.at_tail_weight;

  %% Total scores
  score = hairpin_score + dimer_score + gc_score + tm_score + at_score;
  % Left in for debugging purposes, the code inside the if should not be run
  % under normal circumstances.
  if numel(score) ~= 1
      disp('hairpin_score')
      disp(hairpin_score)
      disp('dimer_score')
      disp(dimer_score)
      disp('gc_score')
      disp(gc_score)
      disp('tm_score')
      disp(tm_score)
      disp('at_score')
      disp(at_score)
      disp('score')
      disp(score)
  end
end

function length = longest_hairpin(hairpin_result)
  % Find the longest haipin's length based on the results from oligoprop.
  runs = regexp(hairpin_result, '[A-Z]*', 'match');
  length = 0;
  for run = runs
      if numel(run) > length
          length = numel(run);
      end
  end
end

function score = at_tail_score(seq)
  % Penalize a sequence for having too many GC in its tail.
  n_bp = 5;
  score = gc_count(seq(end-n_bp+1:end));
end
