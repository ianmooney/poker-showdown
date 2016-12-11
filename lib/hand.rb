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

  # Compares this hand with another hand so that an array of hands can be sorted
  # Returns -1 if this hand is better
  # Returns 0 if both hands are equal
  # Returns 1 if the other hand is better
  def <=>(other_hand)
    if other_hand.type == type
      # If both hands are the same type, we need to compare the card ranks
      # Loop through all ranks, which are specially sorted depending on type, see #sorted_card_ranks
      sorted_card_ranks.each_with_index do |rank, i|
        other_rank = other_hand.sorted_card_ranks[i]

        if other_rank == rank
          # If cards are the same rank, then move on and compare the next card
          next
        else
          # If cards are different, compare ranks to see which one is higher
          return other_rank <=> rank
        end
      end
    end

    # Otherwise fall back to comparing the hand types, e.g. Flush beats One Pair
    other_hand.type <=> type
  end

  def ties_with?(other_hand)
    (self <=> other_hand) == 0
  end

  protected

  # Returns all card ranks, sorted depending on the hand type
  # e.g.
  # Flush or High Card: return ranks highest to lowest
  # Three of a Kind:    return 3 matching ranks first, then the rest highest to lowest
  # One Pair:           return 2 paired ranks first, then the rest highest to lowest
  def sorted_card_ranks
    sorted_ranks = cards.collect(&:rank).sort.reverse

    case type
    when FLUSH, HIGH_CARD
      sorted_ranks
    when THREE_OF_A_KIND
      ranks_with_triple_at_front(sorted_ranks)
    when ONE_PAIR
      ranks_with_pair_at_front(sorted_ranks)
    end
  end

  private

  def ranks_with_triple_at_front(ranks)
    # Find the rank that occurs 3 times (there can only be one)
    tripled_rank = card_rank_counts.detect{ |k, v| v >= 3 }[0]
    # Remove 3 instances of the rank (exactly 3, in case it occurs 4 times)
    3.times { ranks.slice!(ranks.index(tripled_rank)) }
    # Prepend the 3 ranks to the front of array
    [tripled_rank]*3 + ranks
  end

  def ranks_with_pair_at_front(ranks)
    # Find all ranks that occur exactly twice
    paired_ranks = card_rank_counts.select { |k, v| v == 2 }
    # Find the paired rank that has the highest value, we'll ignore any others
    paired_rank = paired_ranks.keys.max
    # Remove the 2 instances of the rank
    ranks.delete(paired_rank)
    # Prepend the 2 ranks to the front of array
    [paired_rank]*2 + ranks
  end

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
    @card_rank_counts ||= cards.inject(Hash.new(0)) do |hash, card|
      hash[card.rank] += 1
      hash
    end
  end
end
