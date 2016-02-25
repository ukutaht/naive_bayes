require 'classifier'
require 'tokeniser'

RSpec.describe Classifier do
  let(:tokeniser)  { Tokeniser.new }
  let(:classifier) { Classifier.new }

  let(:training_set) do
    spam = [
      'win money',
      'nigerian prince wants money',
      'get money',
    ]

    ham = [
      'office keys',
      'party next week',
      'working from home today',
    ]

    label(tokenise_all(spam), 'spam') + label(tokenise_all(ham), 'ham')
  end

  it 'classifies ham vs spam' do
    classifier.train(training_set)

    expect(classifier.classify(tokenise('money'))).to eq('spam')
    expect(classifier.prob_classify(tokenise('money'))).to eq([
      ['spam', 0.1875],
      ['ham', 0.0]
    ])

    expect(classifier.classify(tokenise('office'))).to eq('ham')
    expect(classifier.prob_classify(tokenise('office'))).to eq([
      ['spam', 0.0],
      ['ham', 0.05555555555555555]
    ])
  end

  # see: https://en.wikipedia.org/wiki/Additive_smoothing
  # note that this will break the specifc probability expectations in the previous test
  xit 'implements parameter smoothing' do
    classifier.train(training_set)

    probabilities = classifier.prob_classify(tokenise('money')).map {|pair| pair[1]}

    expect(probabilities).to all( be > 0 )
  end

  def label(texts, label)
    texts.map {|text| [text, label]}
  end

  def tokenise_all(texts)
    texts.map {|t| tokenise(t)}
  end

  def tokenise(text)
    tokeniser.tokenise(text)
  end
end
