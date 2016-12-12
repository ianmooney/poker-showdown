RSpec.describe Card do
  describe '#initialize' do
    let(:card) { Card.new(name) }

    context 'name is 2D' do
      let(:name) { '2D' }

      it { expect(card.rank).to eq(2) }
      it { expect(card.suit).to eq('D') }
    end

    context 'name is 10C' do
      let(:name) { '10C' }

      it { expect(card.rank).to eq(10) }
      it { expect(card.suit).to eq('C') }
    end

    context 'name is JC' do
      let(:name) { 'JC' }

      it { expect(card.rank).to eq(11) }
      it { expect(card.suit).to eq('C') }
    end

    context 'name is QS' do
      let(:name) { 'QS' }

      it { expect(card.rank).to eq(12) }
      it { expect(card.suit).to eq('S') }
    end

    context 'name is KH' do
      let(:name) { 'KH' }

      it { expect(card.rank).to eq(13) }
      it { expect(card.suit).to eq('H') }
    end

    context 'name is AH' do
      let(:name) { 'AH' }

      it { expect(card.rank).to eq(14) }
      it { expect(card.suit).to eq('H') }
    end

    context 'name is 1H' do
      let(:name) { '1H' }

      it 'raises an error' do
        expect{ card }.to raise_error(Errors::InvalidCard, "#{name} is an invalid card.")
      end
    end

    context 'name is 11H' do
      let(:name) { '11H' }

      it 'raises an error' do
        expect{ card }.to raise_error(Errors::InvalidCard, "#{name} is an invalid card.")
      end
    end

    context 'name is BH' do
      let(:name) { 'BH' }

      it 'raises an error' do
        expect{ card }.to raise_error(Errors::InvalidCard, "#{name} is an invalid card.")
      end
    end

    context 'name is AB' do
      let(:name) { 'AB' }

      it 'raises an error' do
        expect{ card }.to raise_error(Errors::InvalidCard, "#{name} is an invalid card.")
      end
    end
  end
end
