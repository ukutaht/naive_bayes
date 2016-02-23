require 'tokeniser'

RSpec.describe Tokeniser do
  it 'splits on word boundary' do
    tokeniser = Tokeniser.new

    expect(tokeniser.tokenise('word1 word2')).to eq(['word1', 'word2'])
  end
end
