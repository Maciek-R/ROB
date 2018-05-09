function new_labels = prepareBuckets(old_labels, groups)

  new_labels = old_labels;
  for i=1:rows(old_labels)
    new_labels(i) = groups(old_labels(i));
  end
