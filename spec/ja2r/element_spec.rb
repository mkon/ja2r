RSpec.describe JA2R::Element do
  subject(:element) { described_class.new origin_data, options }

  let(:origin_data) do
    {
      'id' => 'some-id',
      'attributes' => {
        'foo' => 'foo-value',
        'bar' => {
          'bar-value' => true
        }
      }
    }
  end
  let(:options) { {} }

  describe 'fetching existing attributes' do
    it 'returns the value' do
      expect(element.foo).to eq 'foo-value'
      expect(element.bar).to eq('bar-value' => true)
    end
  end

  describe 'fetching non-existing attributes' do
    it 'raises method not found error' do
      expect { element.unknown }.to raise_error(NoMethodError)
    end
  end

  context 'when using safe_traverse' do
    let(:options) { {safe_traverse: true} }

    describe 'fetching existing attributes' do
      it 'returns the value' do
        expect(element.foo).to eq 'foo-value'
        expect(element.bar).to eq('bar-value' => true)
      end
    end

    describe 'fetching non-existing attributes' do
      it 'does not raise method not found error, but returns nil' do
        expect(element.unknown).to be_nil
      end
    end
  end
end
