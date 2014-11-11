function [lst_primers] = find_near_exonjunction(longsequence,junctionposition)
LengthOfPrimer = 19;
% returns first index of junctionposition within longseqence
k = strfind(longsequence,junctionposition); 
%Variables containing junctionposition index + 200 NT upstream and - 200 NT
%downstream
x = k+200;
y = k-200; 
%add +200 to y to avoid negative values
a=y+200;
%concatonate x to y indices. So z contains the junctionpositions +/- 200NT  
z = [a:x];
%Loop from the first position of z to the last position of z minus
%LengthOfPrimer (19)
%NOT SURE WHAT TO DO NOW....
for i = 1:length(z)-LengthOfPrimer
    lst_primers = [];
    PotentialPrimer = z(i:i+LengthOfPrimer);
    RequirementVector = ['g','c'];
    %function to see if PotentialPrimer matches 
    %strcmpi - (case insensitive)
    lst_primers(end+1) = strcmp(RequirementVector, PotentialPrimer);
end
%checks if last 5 out of 19 NT contains 3/5 g or c
%     if i({15:20}) == 'g' | 'c'
%         true
%     else
%         false
%     end
% end
function [lst_primers] = find_near_exonjunction(longsequence, ...
  junctionposition, opts)
% This function locates primers centered on an exon junction.
if ~isfield(opts, 'n_candidates')
  % Arbitrary default
  opts.n_candidates = 10
end

%% other stuff

end
