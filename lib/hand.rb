class Hand
  NUM_CARDS = 5

  # Hand types
  FLUSH           = 4
  THREE_OF_A_KIND = 3
  ONE_PAIR        = 2
  HIGH_CARD       = 1

  attr_accessor :player_name, :cards, :type

  def initialize(player_name, card_names)
    @player_name = player_name
    @cards = [*card_names].collect { |name| Card.new(name) }

    # Run validations and return errors if neccessary
    validate!

    # Determine the hand type: Flush, Three of a Kind, One Pair or High Card
    @type = determine_type(@cards)
  end

  private
  def validate!
    if [nil, ''].include?(player_name)
      raise Errors::InvalidHand, 'Player name is blank.'
    elsif cards.size != NUM_CARDS
      raise Errors::InvalidHand, "Needs exactly #{NUM_CARDS} cards."
    elsif cards.collect(&:name).uniq.size != NUM_CARDS
      raise Errors::InvalidHand, "Contains duplicate cards."
    end
  end

  def determine_type(cards)
    if cards.collect(&:suit).uniq.count == 1
      # If all suits are the same, it is a flush
      FLUSH
    elsif card_rank_counts.values.any? { |v| v >= 3 }
      # If the same rank occurs at least 3 times, it is a three of a kind
      THREE_OF_A_KIND
    elsif card_rank_counts.values.any? { |v| v == 2 }
      # If the same rank occurs twice, it is a one pair
      ONE_PAIR
    else
      # Otherwise if none of the above, it defaults to high card
      HIGH_CARD
    end
  end

  # Returns a hash of card ranks and the number of cards with that rank
  # e.g. a hand of [4H, 4D, 4C, KS, QH]
  # {
  #   '4' => 3,
  #   'K' => 1,
  #   'Q' => 1
  # }
  def card_rank_counts
    cards.inject(Hash.new(0)) do |hash, card|
      hash[card.rank] += 1
      hash
    end
  end
end
