RSpec.describe JA2R do
  let(:payload) { JSON.parse(File.read(File.expand_path('fixtures/singular.json', __dir__))) }
  let(:json_list) { JSON.parse(File.read(File.expand_path('fixtures/list.json', __dir__))) }

  it 'can handle singular relations' do
    ele = described_class.parse payload
    expect(ele.id).to eq '1001'
    expect(ele.sister.id).to eq '1002'
    expect(ele.sister.name).to eq 'Lisa'
    expect(ele.father.id).to eq '998'
    expect(ele.father.name).to eq 'Homer'
    expect(ele.father.car.name).to eq 'PinkSedan'
  end

  it 'can handle lists' do
    list = described_class.parse json_list
    expect(list.size).to eq 3
    expect(list.first.name).to eq 'Homer'
    expect(list.first.pets.size).to eq 2
  end
end
