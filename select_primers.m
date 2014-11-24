function [lst_primers] = select_primers(longsequence, opts)
% This is the main function that selects primers based on a
% longsequence (the actual transcript to amplify for), and a struct of
% options.
[lst_fwd_primers_starts, lst_rev_primers_starts] = ...
    find_near_exonjunction(longsequence, opts.exonjunction);
primer_len = [18:24];

%% Calculate forward primers
[lst_fwd_locs, lst_fwd_lengths] = meshgrid(lst_fwd_primers_starts, ...
primer_len);
% lst_fwd_locs = lst_fwd_locs(:);
% lst_fwd_lengths = lst_fwd_lengths(:);
fwd_primers = {};
fwd_scores = zeros(1, numel(lst_fwd_locs));
for iI = 1:numel(lst_fwd_locs)
    primerseq = longsequence(lst_fwd_locs(iI): lst_fwd_locs(iI) + ...
        lst_fwd_lengths(iI) - 1);
    fwd_primers(end+1) = {primerseq};
    score = individual_scoring(primerseq, opts);
    disp(score)
    fwd_scores(iI) = score;
end
disp(fwd_scores)

%% Calculate reverse primers
[lst_rev_locs, lst_rev_lengths] = meshgrid(lst_rev_primers_starts, ...
primer_len);
rev_primers = {};
rev_scores = zeros(1, numel(lst_rev_locs));
for iI = 1:numel(lst_rev_locs)
    primerseq = longsequence(lst_rev_locs(iI): lst_rev_locs(iI) + ...
        lst_rev_lengths(iI) - 1);
    rev_primers(end+1) = {primerseq};
    rev_scores(iI) = individual_scoring(primerseq, opts);
end
disp(rev_scores)

%% Filter by top scorers

%% Find best pairs
end
