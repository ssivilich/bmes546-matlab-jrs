function score = pair_scoring(primers, ind_scores, longseq, opts)
% Score a primer set based on factors determined by opts.
% The score will be higher for a poorer primer (like golf).
% Each primer are represented by a length 2 array of [start, length].

if ~isfield(opts, 'tm_diff_weight')
  % Arbitrary default, just for now.
  opts.tm_diff_weight = 1;
end

if ~isfield(opts, 'tm_opt_weight')
  % Arbitrary default, just for now.
  opts.tm_opt_weight = 1;
end

if ~isfield(opts, 'ind_score_weight')
  % Arbitrary default, just for now.
  opts.ind_score_weight = 20;
end

if ~isfield(opts, 'amplicon_length_weight')
  % Arbitrary default, just for now.
  opts.amplicon_length_weight = 20;
end

if ~isfield(opts, 'amplicon_length_opt')
  % Arbitrary default, just for now.
  opts.amplicon_length_opt = 200;
end

if ~isfield(primers, 'forward') | ~isfield(primers, 'reverse')
  ME = MException('primer_score:incompletePrimers', ...
    'Either the forward or reverse primers were not provided');
  throw(ME);
end

% this may change
comb_ind_scores = ind_scores.forward + ind_scores.reverse;

% disp(primers.forward);
% disp(primers.reverse);
% [forward_start, forward_length] = primers.forward;
forward_start = primers.forward(1);
forward_length = primers.forward(2);
seq_forward = longseq(forward_start:forward_start + forward_length);
% [reverse_start, reverse_length] = primers.reverse;
reverse_start = primers.reverse(1);
reverse_length = primers.reverse(2);
seq_reverse = seqrcomplement( ...
  longseq(reverse_start - reverse_length:reverse_start));

props.forward = oligoprop(seq_forward);
props.reverse = oligoprop(seq_reverse);

%% calculate Tm part of score
Tm_mean = mean([props.forward.Tm; props.reverse.Tm]);

tm_score = dot(props.forward.Tm - Tm_mean, props.reverse.Tm - Tm_mean) ...
  * opts.tm_diff_weight + ...
  (sum(mean([props.forward.Tm; props.reverse.Tm])) - opts.tm_opt) * ...
    opts.tm_opt_weight;

%% calculate amplicon length part of score
amplicon_length = reverse_start - forward_start;
amplicon_length_diff = amplicon_length - opts.amplicon_length_opt;

%% calculate total score
score = tm_score + opts.ind_score_weight * comb_ind_scores + ...
opts.amplicon_length_weight * amplicon_length_diff;

end
