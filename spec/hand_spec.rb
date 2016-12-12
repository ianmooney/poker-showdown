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
        expect{ hand }.to raise_error(Errors::InvalidHand, "Hands needs exactly 5 cards.")
      end
    end

    context 'contains duplicate card' do
      let(:card_names)  { %w(KH KH KC 4S 8H) }

      it 'raises error' do
        expect{ hand }.to raise_error(Errors::InvalidHand, "Hand contains duplicate cards.")
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

  describe '#<=>' do
    subject { hand <=> other_hand }
    let(:other_hand) { Hand.new('Fred', other_card_names) }

    ## Testing Flush
    context 'this hand is a flush' do
      let(:card_names) { %w(3H 4H 5H 6H 8H) }

      context 'other hand is a three of a kind' do
        let(:other_card_names) { %w(KH KD KC 4S 8H) }

        it 'this hand wins' do
          is_expected.to eq(-1)
        end
      end

      context 'other hand is also a flush' do
        context 'both flushes are equal' do
          let(:other_card_names) { %w(3D 4D 5D 6D 8D) }

          it 'is a tie' do
            is_expected.to eq(0)
          end
        end

        context 'other hand has a higher card' do
          let(:other_card_names) { %w(3D 4D 5D 7D 8D) }

          it 'other hand wins' do
            is_expected.to eq(1)
          end
        end
      end
    end

    ## Testing Three of a Kind
    context 'this hand is a three_of_a_kind' do
      let(:card_names) { %w(3C 3D 3S 8C 10D) }

      context 'other hand is a higher three_of_a_kind' do
        let(:other_card_names) { %w(5C 5D 5S 2S 9C) }

        it 'other hand wins' do
          is_expected.to eq(1)
        end
      end

      context 'other hand is a flush' do
        let(:other_card_names) { %w(3D 4D 5D 6D 8D) }

        it 'other hand wins' do
          is_expected.to eq(1)
        end
      end

      context 'other hand is a one_pair' do
        let(:other_card_names) { %w(10H KD KC 4S 8H) }

        it 'this hand wins' do
          is_expected.to eq(-1)
        end
      end
    end

    ## Testing One Pair
    context 'this hand is a one_pair' do
      let(:card_names) { %w(6H 6S 5H QC 4H) }

      context 'other hand has a higher one_pair' do
        let(:other_card_names) { %w(9C 9H KS 6H 8H) }

        it 'other hand wins' do
          is_expected.to eq(1)
        end
      end

      context 'other hand has an equal one_pair' do
        context 'and all other cards are equal' do
          let(:other_card_names) { %w(6C 6H 5S QH 4H) }

          it 'is a tie' do
            is_expected.to eq(0)
          end
        end

        context 'other hand has a higher card' do
          let(:other_card_names) { %w(6C 6H 5S KH 4H) }

          it 'other hand wins' do
            is_expected.to eq(1)
          end
        end
      end

      context 'other hand has 2 pairs, one higher and one lower' do
        let(:other_card_names) { %w(4C 4H 5S 7H 7S) }

        it 'other hand wins' do
          is_expected.to eq(1)
        end
      end
    end

    ## Testing High Card
    context 'this hand is a high_card' do
      let(:card_names) { %w(AC 10C 5C 2S 9C) }

      context 'other hand has a lower high_card' do
        let(:other_card_names) { %w(3C KD QS 8C 10D) }

        it 'this hand wins' do
          is_expected.to eq(-1)
        end
      end

      context 'other hand has the same high_card but second card is higher' do
        let(:other_card_names) { %w(3C AD QS 8C 10D) }

        it 'other hand wins' do
          is_expected.to eq(1)
        end
      end

      context 'other hand all cards of equal rank' do
        let(:other_card_names) { %w(2C AD 10S 5C 9D) }

        it 'is a tie' do
          is_expected.to eq(0)
        end
      end
    end
  end
end
