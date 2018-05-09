function res = find_p(pair_, dat)
  x = pair_(1);
  y = pair_(2);
  first = dat(dat(:, 1) == x, :);
  res = first(first(:, 2) == y, :);
end