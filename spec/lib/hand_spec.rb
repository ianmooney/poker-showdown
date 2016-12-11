RSpec.describe Hand do
  let(:hand)        { Hand.new(player_name, card_names) }
  let(:player_name) { 'Joe' }
  let(:card_names)  { %w(KH KD KC 4S 8H) }

  describe '#initialize' do
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
      let(:card_names) { [] }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, "Needs exactly 5 cards.")
      end
    end

    context 'contains duplicate card' do
      let(:card_names)  { %w(KH KH KC 4S 8H) }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, "Contains duplicate cards.")
      end
    end
  end
  end
end
