# This class represents a playing card, e.g. the Queen of Hearts
# e.g. card = Card.new('QH')
class Card
  SUITS = ['H', 'D', 'C', 'S']
  NON_INTEGER_RANKS = {
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  attr_accessor :name, :rank, :suit

  def initialize(name)
    @name = name
    @rank = rank_from_name(name)
    @suit = suit_from_name(name)
    validate!
  end

  private

  def rank_from_name(name)
    rank = name.chop # Remove last character (the suit)

    if rank.to_i > 1 && rank.to_i < 11
      # Only allow ranks 2 to 10
      rank.to_i
    elsif NON_INTEGER_RANKS[rank]
      NON_INTEGER_RANKS[rank]
    end
  end

  def suit_from_name(name)
    suit = name[-1] # Get last character
    suit if SUITS.include?(suit)
  end

  def validate!
    if rank.nil? || suit.nil?
      raise Errors::InvalidCard, "#{name} is an invalid card."
    end
  end
end
