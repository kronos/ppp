RSpec.describe PPP::LineItemParser do
  let(:item) do
    '1 105350        AMANA ELEC DRYER WHITE' \
    '                1   374.7900     374.79'
  end
  subject { PPP::LineItemParser.new(item) }

  describe '.parsed_line_item' do
    it 'parses data' do
      expect(subject.parsed_line_item).to eq(description: 'AMANA ELEC DRYER WHITE',
                                             item_number: 105_350,
                                             line_number: 1,
                                             quantity: 1,
                                             unit_price: 374.79)
    end
  end
end
