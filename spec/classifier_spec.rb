require 'classifier'
require 'tokeniser'

RSpec.describe Classifier do
  let(:tokeniser)  { Tokeniser.new }
  let(:classifier) { Classifier.new }

  it 'classifies spam' do
    spam = [
      "Win £2000 by clicking this link!",
      "Nigerian prince looking for your help",
      "This is not a pyramid scheme, honestly.",
      "Fast and easy way to get money, just click here"
    ]

    ham = [
      "Time to check in to your flight London - Tenerife",
      "Birthday party next week!"
    ]

    training_set = label(tokenise_all(spam), 'spam') + label(tokenise_all(ham), 'ham')

    classifier.train(training_set)

    expect(classify(tokenise('Win money by clicking link!'))).to eq('spam')
    expect(classify(tokenise('Time to check in'))).to eq('ham')
    expect(classifier.prob_classify(tokenise('Win money'))).to eq([
        ["spam", 0.16666666666666666],
        ["ham", 0.0]
    ])
  end

  it 'classifier names' do
    play = [
      ['outlook(overcast)', 'temp(hot)', 'humidity(high)', 'wind(weak)'],
      ['outlook(rain)', 'temp(mild)', 'humidity(high)', 'wind(weak)'],
      ['outlook(rain)', 'temp(cool)', 'humidity(normal)', 'wind(weak)'],
      ['outlook(overcast)', 'temp(cool)', 'humidity(normal)', 'wind(strong)'],
      ['outlook(sunny)', 'temp(cool)', 'humidity(normal)', 'wind(weak)'],
      ['outlook(rain)', 'temp(mild)', 'humidity(normal)', 'wind(weak)'],
      ['outlook(sunny)', 'temp(mild)', 'humidity(normal)', 'wind(strong)'],
      ['outlook(overcast)', 'temp(mild)', 'humidity(high)', 'wind(strong)'],
      ['outlook(overcast)', 'temp(hot)', 'humidity(normal)', 'wind(weak)'],
    ]

    not_play = [
      ['outlook(sunny)', 'temp(hot)', 'humidity(high)', 'wind(weak)'],
      ['outlook(sunny)', 'temp(hot)', 'humidity(high)', 'wind(strong)'],
      ['outlook(rain)', 'temp(cool)', 'humidity(normal)', 'wind(strong)'],
      ['outlook(sunny)', 'temp(mild)', 'humidity(high)', 'wind(weak)'],
      ['outlook(rain)', 'temp(mild)', 'humidity(high)', 'wind(strong)'],
    ]

    training_set = label(play, 'play') + label(not_play, 'not_play')

    classifier.train(training_set)

    expect(classifier.prob_classify(['outlook(sunny)', 'temp(cool)', 'humidity(high)', 'wind(strong)'])).to eq('female')
  end

  def label(texts, label)
    texts.map {|text| [text, label]}
  end

  def tokenise(text)
    tokeniser.tokenise(text)
  end

  def tokenise_all(texts)
    texts.map {|t| tokenise(t)}
  end

  def classify(text)
    classifier.classify(text)
  end
end
