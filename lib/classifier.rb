class Classifier
  def initialize
  end

  def train(labeled_features)
  end

  def classify(features)
    prob_classify(features)
    .max_by {|_label, prob| prob}
    .first
  end

  def prob_classify(features)
    []
  end
end
