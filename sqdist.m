function m = sqdist(p, q, flag, A)
% SQDIST      Squared Euclidean or Mahalanobis distance.
% SQDIST(p,q)   returns m(i,j) = (p(:,i) - q(:,j))'*(p(:,i) - q(:,j)).
% SQDIST(p,q,A) returns m(i,j) = (p(:,i) - q(:,j))'*A*(p(:,i) - q(:,j)).
% The Lightspeed Matlab toolbox
% Written by Tom Minka

[d, pn] = size(p);
[d, qn] = size(q);

if pn == 0 || qn == 0
  m = zeros(pn,qn);
  return
end

if nargin == 3
  
  pmag = col_sum(p .* p);
  qmag = col_sum(q .* q);
  if flag==2
    m = 40-(repmat(qmag, pn, 1) + repmat(pmag', 1, qn) - 2*p'*q);
  else
  	m = (repmat(qmag, pn, 1) + repmat(pmag', 1, qn) - 2*p'*q);
  end
  %m = ones(pn,1)*qmag + pmag'*ones(1,qn) - 2*p'*q;
  
else

  Ap = A*p;
  Aq = A*q;
  pmag = col_sum(p .* Ap);
  qmag = col_sum(q .* Aq);
  if flag==2
    m = 40-(repmat(qmag, pn, 1) + repmat(pmag', 1, qn) - 2*p'*q);
  else
  	m = (repmat(qmag, pn, 1) + repmat(pmag', 1, qn) - 2*p'*q);
  end
  
end
