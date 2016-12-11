class Hand
  NUM_CARDS = 5

  attr_accessor :player_name, :cards

  def initialize(player_name, cards)
    @player_name = player_name
    @cards = [*cards]
    validate!
  end

  private
  def validate!
    if [nil, ''].include?(player_name)
      raise Errors::InvalidHand, 'Player name is blank.'
    elsif cards.size != NUM_CARDS
      raise Errors::InvalidHand, "Needs exactly #{NUM_CARDS} cards."
    end
  end
end
