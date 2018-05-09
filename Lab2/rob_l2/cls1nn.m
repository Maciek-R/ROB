function lab = cls1nn(ts, x)
% 1NN classifier
% ts - training set; first column contains labels
% x - sample to be classsified; no label here
% out:
%   lab - x's nearest neighbour label

  distsq = sumsq(ts(:, 2:end) - repmat(x, rows(ts), 1), 2);
  [mv, mi] = min(distsq);
  lab = ts(mi, 1);
  
end
 