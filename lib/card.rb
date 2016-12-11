class Card
  SUITS = ['H', 'D', 'C', 'S']
  LETTER_VALUES = {
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  attr_accessor :name, :value, :suit

  def initialize(name)
    @name = name
    @value = value_from_name(name)
    @suit = suit_from_name(name)
  end

  private
  def value_from_name(name)
    value = name.chop # Remove last character (the suit)

    if value.to_i > 1 && value.to_i < 11
      # Only allow values 2 to 10
      value.to_i
    elsif LETTER_VALUES[value]
      LETTER_VALUES[value]
    else
      raise Errors::InvalidCard, "#{name} is an invalid card."
    end
  end

  def suit_from_name(name)
    suit = name[-1] # Get last character

    if SUITS.include?(suit)
      suit
    else
      raise Errors::InvalidCard, "#{name} is an invalid card."
    end
  end
end
