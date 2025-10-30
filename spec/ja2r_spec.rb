RSpec.describe JA2R do
  let(:payload) { JSON.parse(File.read(File.expand_path('fixtures/singular.json', __dir__))) }
  let(:json_list) { JSON.parse(File.read(File.expand_path('fixtures/list.json', __dir__))) }

  it 'can handle singular relations' do
    ele = described_class.parse payload
    expect(ele.id).to eq '1001'
    expect(ele.best_friend.name).to eq 'Milhouse'
    expect(ele.sister.id).to eq '1002'
    expect(ele.sister.name).to eq 'Lisa'
    expect(ele.father.id).to eq '998'
    expect(ele.father.name).to eq 'Homer'
    expect(ele.father.car.name).to eq 'PinkSedan'
  end

  it 'can read links' do
    ele = described_class.parse payload
    expect(ele.link('self')).to eq 'http://bart'
  end

  it 'can read meta' do
    ele = described_class.parse payload
    expect(ele.meta('example')).to be true
  end

  it 'can handle lists' do
    list = described_class.parse json_list
    expect(list.size).to eq 3
    expect(list.first.name).to eq 'Homer'
    expect(list.first.pets.size).to eq 2
  end

  context 'when using safe_traverse' do
    it 'returns nil on unknown fields' do
      ele = described_class.parse payload, safe_traverse: true
      expect(ele.uncle).to be_nil
    end
  end

  describe 'using custom class registry' do
    around do |example|
      JA2R::KlassRegistry.register 'persons', person_klass
      example.run
    end

    let(:person_klass) { Class.new(JA2R::Element) }

    it 'uses the right classes' do
      ele = described_class.parse payload
      expect(ele).to be_a(person_klass)
    end
  end
end
