class Hand
  NUM_CARDS = 5
  TYPES = {
    flush:           'Flush',
    three_of_a_kind: 'Three of a Kind',
    one_pair:        'One Pair',
    high_card:       'High Card'
  }

  attr_accessor :player_name, :cards

  def initialize(player_name, card_names)
    @player_name = player_name
    @cards = [*card_names].collect { |name| Card.new(name) }
    validate!
  end

  def hand_type
    if cards.collect(&:suit).uniq.count == 1
      :flush
    elsif sorted_card_ranks.values.any? { |v| v >= 3 }
      :three_of_a_kind
    elsif sorted_card_ranks.values.any? { |v| v == 2 }
      :one_pair
    else
      :high_card
    end
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

  # Returns a hash of card ranks and the number of cards with that rank
  # e.g. a hand of [4H, 4D, 4C, KS, QH]
  # {
  #   '4' => 3,
  #   'K' => 1,
  #   'Q' => 1
  # }
  def sorted_card_ranks
    cards.inject(Hash.new(0)) do |hash, card|
      hash[card.rank] += 1
      hash
    end
  end
end
