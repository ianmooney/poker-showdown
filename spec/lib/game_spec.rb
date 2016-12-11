RSpec.describe Game do
  let(:game) do
    Game.new([
      Hand.new('Joe',   joes_cards),
      Hand.new('Bob',   bobs_cards),
      Hand.new('Sally', sallys_cards)
    ])
  end

  let(:joes_cards)   { %w(3H 4H 5H 6H 8H) }
  let(:bobs_cards)   { %w(3C 3D 3S 8C 10D) }
  let(:sallys_cards) { %w(AC 10C 5C 2S 2C) }

  describe '#winning_player_names' do
    subject { game.winning_player_names }

    context 'Joe has a flush' do
      it { is_expected.to eq(['Joe']) }

      context 'Bob has an equal flush' do
        let(:bobs_cards) { %w(3C 4C 5C 6C 8C) }

        it { is_expected.to match_array(['Joe', 'Bob']) }
      end

      context 'Bob and Sally both have an equal flush' do
        let(:bobs_cards)   { %w(3C 4C 5C 6C 8C) }
        let(:sallys_cards) { %w(3S 4S 5S 6S 8S) }

        it { is_expected.to match_array(['Joe', 'Bob', 'Sally']) }
      end
    end
  end
end
