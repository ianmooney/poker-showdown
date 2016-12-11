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

    context 'when determining type' do
      context 'hand is a flush' do
        let(:card_names) { %w(2H 3H 4H 5H 6H) }

        it { expect(hand.type).to eq(Hand::FLUSH) }
      end

      context 'hand is a three of a kind' do
        let(:card_names) { %w(3H 3D 3C 5H 6H) }

        it { expect(hand.type).to eq(Hand::THREE_OF_A_KIND) }
      end

      context 'hand is a four of a kind' do
        let(:card_names) { %w(3H 3D 3C 3S 6H) }

        it { expect(hand.type).to eq(Hand::THREE_OF_A_KIND) }
      end

      context 'hand is one pair' do
        let(:card_names) { %w(JH JD 3C 5H 6H) }

        it { expect(hand.type).to eq(Hand::ONE_PAIR) }
      end

      context 'hand is high card' do
        let(:card_names) { %w(2D 3H 4H 5H 6H) }

        it { expect(hand.type).to eq(Hand::HIGH_CARD) }
      end
    end
  end
end
