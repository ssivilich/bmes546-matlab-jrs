function primerpairs  = select_primers(longsequence, opts)
  % This is the main function that selects primers based on a
  % longsequence (the actual transcript to amplify for), and a struct of
  % options.

  %% Set default options
  if ~isfield(opts, 'n_top_score')
    opts.n_top_score = 20;
  end

  if ~isfield(opts, 'n_top_pair_score')
    opts.n_top_pair_score = 10;
  end

  if ~isfield(opts, 'tm_opt')
    opts.tm_opt = 59;
  end

  [lst_fwd_primers_starts, lst_rev_primers_starts] = ...
      find_near_exonjunction(longsequence, opts.exonjunction);
  primer_len = [19:22];

  %% Calculate forward primers
  [lst_fwd_locs, lst_fwd_lengths] = meshgrid(lst_fwd_primers_starts, ...
  primer_len);
  fwd_primers = {};
  fwd_scores = zeros(1, numel(lst_fwd_locs));
  for iI = 1:numel(lst_fwd_locs)
      primerseq = get_fwd_primer(longsequence, lst_fwd_locs(iI), ...
          lst_fwd_lengths(iI));
      fwd_primers(end+1) = {primerseq};
      score = individual_scoring(primerseq, opts);
      fwd_scores(iI) = score;
  end

  %% Calculate reverse primers
  [lst_rev_locs, lst_rev_lengths] = meshgrid(lst_rev_primers_starts, ...
  primer_len);
  rev_primers = {};
  rev_scores = zeros(1, numel(lst_rev_locs));
  for iI = 1:numel(lst_rev_locs)
      primerseq = get_rev_primer(longsequence, lst_rev_locs(iI), ...
          lst_rev_lengths(iI));
      rev_primers(end+1) = {primerseq};
      score = individual_scoring(primerseq, opts);
      rev_scores(iI) = score;
  end

  %% Filter by top scorers
  % For fwd
  [sort_scores, sort_ind] = sort(fwd_scores, 'descend');
  topscores_ind = sort_ind(1:min(numel(sort_scores),opts.n_top_score));
  topfwdscores = sort_scores(topscores_ind);
  topfwdseqs = fwd_primers(topscores_ind);
  topfwdlocs = [lst_fwd_locs(topscores_ind); lst_fwd_lengths(topscores_ind)];

  % For rev
  [sort_scores, sort_ind] = sort(rev_scores, 'descend');
  topscores_ind = sort_ind(1:min(numel(sort_scores), opts.n_top_score));
  toprevscores = sort_scores(topscores_ind);
  toprevseqs = rev_primers(topscores_ind);
  toprevlocs = [lst_rev_locs(topscores_ind); lst_rev_lengths(topscores_ind)];

  %% Find best pairs
  i = 1:size(topfwdseqs, 2);
  j = 1:size(toprevseqs, 2);
  [J, I] = meshgrid(i, j);
  pairscore = zeros(numel(J));
  for iter = 1:numel(J)
      [primers.forward] = topfwdlocs(:, I(iter))';
      [primers.reverse] = toprevlocs(:, J(iter))';
      [ind_scores.forward] = topfwdscores(I(iter));
      [ind_scores.reverse] = toprevscores(I(iter));
      pairscore(iter) = pair_scoring(primers, ind_scores, longsequence, opts);
  end
  [sort_scores, sort_ind] = sort(pairscore, 'ascend');
  topscores_ind = sort_ind(1:opts.n_top_pair_score);
  topfwdseqs = topfwdseqs(:, I(topscores_ind));
  toprevseqs = toprevseqs(:, J(topscores_ind));
  primerpairs = struct('fwdseq', {}, 'revseq', {});
  for iter = 1:opts.n_top_pair_score
      primerpairs(iter).fwdseq = topfwdseqs(iter);
      primerpairs(iter).revseq = toprevseqs(iter);
      primerpairs(iter).score = pairscore(topscores_ind(iter));
  end
end
