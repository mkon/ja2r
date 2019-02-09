RSpec.describe JA2R::Parser do
  subject(:parser) { described_class.new hash }

  describe '#call' do
    subject { parser.call }

    context 'when parsing non-json-api' do
      let(:hash) { {'foo' => {}} }

      it { is_expected.to eq nil }
    end
  end
end
