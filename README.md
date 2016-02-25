# Naive Bayes workshop

In this repository you'll find the skeleton for writing your own naive bayes classifier.

The classifier should confirm to the standard interface with two methods: `train` and `classify`.
In this example, the method `prob_classify` is exposed as well so that we can inspect the actual
probabilities during testing.

#### Training data

The classifier expects training data in a specific format. It should be a list of tuples containing
the featureset in the first position and the given label in the second position. For simplicity,
features are represented as strings (this limits us to discrete values, a real-world implementation
should allow numerical values as well)

Here's an example of a training set:
```ruby
training_set = [
  ['win', 'money'], 'spam',
  ['office', 'supplies'], 'ham',
]
```

This represents that a message containing both `"win"` and `"money"` is spam and
the other example is not spam. For simple text classification, the features are going to be just tokenised text.

#### Classification

To classify a new set of features we pass in just the featureset (without the label) and expect a label
in return:

```ruby
classifier.classify(['win', 'money']) => 'spam'
```

#### Training vs Classification

The training step exists in the standard classifier interface for performance reasons. Technically we could
just pass the training data in for every individual classification (e.g `classifier.classify(training_data, featureset)`) and still get a correct result.
However this means that all frequencies and
probabilities would need to be recalculated for each classification.

To start out with, you may want to just record
all training data in the `train` method and run all calculations in `classify` to make the problem simpler. Worry
about correctess before optimising. To handle large data sets, however, you may want to make use of the preprocessing step and memoize some calculations.

#### Tests

There are two tests in `spec/classifier_spec.rb`, one of them ignored at first. The first test should force you to
implement the basic Naive Bayes classifier. The second test forces a very important addition to the classifier called
smoothing. This solves the zero-frequency problem that maximum likelihood estimations suffer from.

#### Evaluation

To evaluate how well the classifier performs, there are ~5500 text messages in the `data` directory. The executable
in `bin/evaluate` will use your classifier against this test data and return three numbers:
  * Accuracy: Of all classificatins, how many were correct.
  * Percision: Of all 'spam' classifications, how many were actually spam
  * Recall: Of all 'spam' messages, how many were classified as 'spam'

These are standard measurements for classifiers. For spam filters it is important to optimise for high percision (rather of recall)
because false positives are intolerable in spam filters.
