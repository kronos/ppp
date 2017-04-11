RSpec.describe PPP::LineItemsParser do
  let(:line) do
    '1 105350        AMANA ELEC DRYER WHITE                1   374.7900     ' \
    "374.79\n\n   2 105342        AMANA TOP LOAD WASHER                 1   " \
    "339.0000     339.00\n                                                  " \
    '-------'
  end

  subject { PPP::LineItemsParser.new(line) }

  describe '.parsed_line_item' do
    it 'parses data' do
      expect(subject.parsed_line_items).to
      eq([
           {
             line_number: 1,
             item_number: 105_350,
             description: 'AMANA ELEC DRYER WHITE',
             quantity: 1,
             unit_price: 374.79
           },
           {
             line_number: 2,
             item_number: 105_342,
             description: 'AMANA TOP LOAD WASHER',
             quantity: 1,
             unit_price: 339.0
           }
         ])
    end
  end
end
