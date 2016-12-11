class Game
  attr_accessor :winning_hands

  def initialize(hands)
    # Sort hands based on the <=> method defined in Hand
    sorted_hands = hands.sort
    # Retrieve the winning hands, one or more depending on a tie
    @winning_hands = retrieve_winning_hands(sorted_hands)
  end

  def winning_player_names
    winning_hands.collect(&:player_name)
  end

  private
  def retrieve_winning_hands(hands)
    winners = []

    hands.each_with_index do |hand, i|
      # Add first hand to collection of winners
      winners << hand

      next_hand = hands[i+1]
      if next_hand && next_hand.ties_with?(hand)
        # If this hand ties with the next hand, then there are multiple winners
        # Continue loop so the next hand is added to the collection of winners
        next
      else
        # Otherwise break out of the loop because there are no more winning hands
        break
      end
    end

    winners
  end
end
