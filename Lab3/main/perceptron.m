function [sepplane fp fn] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% fp - false positive count (i.e. number of misclassified samples of pclass)
% fn - false negative count (i.e. number of misclassified samples of nclass)

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  tset = [ ones(rows(pclass), 1) pclass; -ones(rows(nclass), 1) -nclass];
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples

  i = 1;
  do 
	%%% YOUR CODE GOES HERE %%%
	%% You should:
	%% 1. Check which samples are misclassified (boolean column vector)
	misclassified = tset*sepplane' < 0;
	%% 2. Compute separating plane correction 
	%%		This is sum of misclassfied samples coordinate times learning rate 
	planeCorrection = sum(tset(misclassified, :)) * 0.0005;
	%% 3. Modify solution (i.e. sepplane)
	sepplane += planeCorrection;
	%% 4. Optionally you can include additional conditions to the stop criterion
	%%		200 iterations can take a while and probably in most cases is unnecessary
	++i;
  until i > 200;

  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers of false positives and false negatives
  misclassified = tset*sepplane' < 0;
  fp = sum(misclassified(1+nPos:end));
  fn = sum(misclassified(1:nNeg));
  
