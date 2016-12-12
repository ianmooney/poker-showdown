# Example input:
# [
#   ['Joe',   ['3H', '4H', '5H', '6H', '8H']],
#   ['Bob',   ['3C', '3D', '3S', '8C', '10D']],
#   ['Sally', ['AC', '10C', '5C', '2S', '2C']]
# ]
class PokerShowdown
  def self.run(input)
    begin
      game = build_game(input)
      puts "Winners: #{game.winning_player_names.join(', ')}"
    rescue Errors::InvalidCard, Errors::InvalidHand => e
      puts "Error: #{e.message}"
    end
  end

  def self.build_game(input)
    hands = build_hands(input)
    Game.new(hands)
  end
  private_class_method :build_game

  def self.build_hands(input)
    input.collect do |player_name, card_names|
      Hand.new(player_name, card_names)
    end
  end
  private_class_method :build_hands
end
