RSpec.describe JA2R::Parser do
  subject(:parser) { described_class.new hash }

  describe '#call' do
    subject { parser.call }

    context 'when parsing non-json-api' do
      let(:hash) { {'foo' => {}} }

      it 'raises JA2R::InvalidData error' do
        expect { parser.call }.to raise_error(JA2R::InvalidData) do |error|
          expect(error.message).to eq 'Hash does not appear to be valid json-api'
          expect(error.data).to eq hash
        end
      end
    end

    context 'when parsing relationships with data nil' do
      let(:hash) do
        {
          'data' => {
            'id' => '123',
            'type' => 'some-type',
            'relationships' => {
              'empty_relationship' => {
                'data' => nil
              }
            }
          }
        }
      end

      it 'returns a JA2R object with niled relationship' do
        expect(subject).to be_a JA2R::Element
        expect(subject.empty_relationship).to be_nil
      end
    end

    context 'when parsing relationships with value nil' do
      let(:hash) do
        {
          'data' => {
            'id' => '123',
            'type' => 'some-type',
            'relationships' => {
              'empty_relationship' => nil
            }
          }
        }
      end

      it 'returns a JA2R object with niled relationship' do
        expect(subject).to be_a JA2R::Element
        expect(subject.empty_relationship).to be_nil
      end
    end

    context 'when parsing data without type' do
      let(:hash) do
        {
          'data' => {
            'id' => '123',
            'attributes' => {
              'one' => 1
            }
          }
        }
      end

      it 'raises JA2R::InvalidData error' do
        expect { parser.call }.to raise_error(JA2R::InvalidData) do |error|
          expect(error.message).to eq 'Hash does not appear to be valid json-api'
          expect(error.data).to eq hash
        end
      end
    end

    context 'when parsing dashed keys' do
      let(:hash) do
        {
          'data' => {
            'id' => '123',
            'type' => 'some-type',
            'attributes' => {
              'some-thing' => 'foo'
            }
          }
        }
      end

      it 'returns a JA2R object with working attributes' do
        expect(subject).to be_a JA2R::Element
        expect(subject.attribute('some-thing')).to eq 'foo'
      end
    end
  end
end
