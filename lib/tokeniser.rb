class Tokeniser
  STOPWORDS = File.readlines('data/stopwords.txt').map {|w| w.strip}

  def tokenise(text)
    (words(text) + custom_features(text)).reject do |w|
      STOPWORDS.include?(w.downcase)
    end
  end

  def words(text)
    text.split(/([\s£%$!#?\+])|[\.,]/).reject {|w| w.strip.empty?}
  end

  def custom_features(text)
    [
      count_uppercase(text),
      count_numbers(text),
    ].compact
  end

  def count_uppercase(text)
    count = text.scan(/\b[A-Z]{2,}\b/).size
    "count_uppercase(#{count})"
  end

  def count_numbers(text)
    count = text.scan(/\b[\+#£$]?\d+[\+%]?\b/).size
    "count_numbers(#{count})"
  end
end
