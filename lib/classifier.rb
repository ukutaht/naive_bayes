class Classifier
  def initialize
    @feature_frequencies = Hash.new()
    @label_frequencies = Hash.new(0)
  end

  def train(labeled_featuresets)
    labeled_featuresets.each do |featureset, label|
      @label_frequencies[label] += 1

      featureset.each do |feature|
        @feature_frequencies[feature] ||= Hash.new(0)
        @feature_frequencies[feature][label] += 1
      end
    end
  end

  def classify(featureset)
    prob_classify(featureset)
    .max_by {|_label, prob| prob}
    .first
  end

  def prob_classify(featureset)
    @label_frequencies.keys.map do |label|
      probability = probability_of_features_in_label(featureset, label) * probability_of_label(label)

      [label, probability]
    end
  end

  private

  def probability_of_label(label)
    @label_frequencies[label] / @label_frequencies.values.reduce(&:+).to_f
  end

  def probability_of_features_in_label(features, label)
    features.map do |f|
      if @feature_frequencies.has_key?(f)
        @feature_frequencies[f][label] / @label_frequencies[label].to_f
      end
    end.compact.reduce(&:*) || 0
  end
end
