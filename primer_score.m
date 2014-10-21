function score = primer_score(primers, opts)
% Score a primer set based on factors determined by opts.
% The score will be higher for a poorer primer (like golf).

score = 0;

if ~isfield(opts, 'tm_diff_weight')
  % Arbitrary default, just for now.
  opts.tm_diff_weight = 1;
end

if ~isfield(opts, 'tm_opt_weight')
  % Arbitrary default, just for now.
  opts.tm_opt_weight = 1;
end

if ~isfield(opts, 'tm_opt')
  opts.tm_opt = 60;
end

if ~isfield(primers, 'forward') | ~isfield(primers, 'reverse')
  ME = MException('primer_score:incompletePrimers', ...
    'Either the forward or reverse primers were not provided');
  throw(ME);
end

props.forward = oligoprop(primers.forward);
props.reverse = oligoprop(primers.reverse);
Tm_mean = mean([props.forward.Tm; props.reverse.Tm]);

tm_score = dot(props.forward.Tm - Tm_mean, props.reverse.Tm - Tm_mean) ...
  * opts.tm_diff_weight + ...
  (sum(mean([props.forward.Tm; props.reverse.Tm])) - opts.tm_opt) * ...
    opts.tm_opt_weight;

% hairpin_score = bleh

end
