RSpec.describe Hand do
  describe '#initialize' do
    let(:hand) { Hand.new(player_name, cards) }
    let(:player_name) { 'Joe' }
    let(:cards) do
      [
        Card.new('KH'),
        Card.new('KD'),
        Card.new('KC'),
        Card.new('4S'),
        Card.new('8H')
      ]
    end

    it 'is valid' do
      expect{ hand }.not_to raise_error
    end

    context 'player name is nil' do
      let(:player_name) { nil }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, 'Player name is blank.')
      end
    end

    context 'player name is blank' do
      let(:player_name) { '' }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, 'Player name is blank.')
      end
    end

    context 'incorrect number of cards' do
      let(:cards) { [] }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, "Needs exactly 5 cards.")
      end
    end
  end
end
