function [lst_primers] = find_near_exonjunction(longsequence, ...
  junctionposition, opts)
% This function locates primers centered on an exon junction.
if ~isfield(opts, 'n_candidates')
  % Arbitrary default
  opts.n_candidates = 10
end

%% other stuff

end
