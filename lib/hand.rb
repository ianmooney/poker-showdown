class Hand
  NUM_CARDS = 5

  attr_accessor :player_name, :cards

  def initialize(player_name, card_names)
    @player_name = player_name
    @cards = [*card_names].collect {|name| Card.new(name) }
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
