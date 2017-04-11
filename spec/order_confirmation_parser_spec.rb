RSpec.describe PPP::OrderConfirmationParser do
  let(:text) do
    'This order will be shipping from our WOR warehouse. Please allow additi' \
    "onal\ntime for delivery.    Also – These items were on the list that I " \
    "already\nemailed the product manager about inventory on for the Chicago" \
    " area. Hope to\nreceive inventory soon in that area.    Thanks\n\n\n\n1" \
    '0/08/14 12:39                 ORDER DETAIL SUMMARY                     ' \
    " PAGE 1\n\nMAINTENANCE U.S.A.\n\nCUSTOMER NAME : PURCHASING PLATFORM   " \
    " LLC               ORDER NUMBER : 12345678\n                 4000 EAST " \
    "134 STREET                    DATE ENTERED : 10/08/14\n                " \
    " JIM KENNEDY (773) 646-2200              TIME ENTERED : 11:06\n\n      " \
    "           CHICAGO                                 STATUS : PENDING\n  " \
    "               IL 60633\n\nPURCHASE ORDER NUMBER : 22551-1\n\n\nLINE IT" \
    'EM NUMBER            DESCRIPTION                QTY     PRICE  EXT AMOU' \
    "NT\n---- ------------ ----------------------------- ------- --------- -" \
    "---------\n   1 105350        AMANA ELEC DRYER WHITE                1  " \
    " 374.7900     374.79\n\n   2 105342        AMANA TOP LOAD WASHER       " \
    "          1   339.0000     339.00\n                                    " \
    "              -------             ----------\nTOTAL LINES :      2     " \
    "          TOTAL QTY :           2 NET            713.79\n\n            " \
    "  THANK YOU FOR YOUR BUSINESS!\n"
  end

  subject { PPP::OrderConfirmationParser.new(text) }

  describe '.parsed_order' do
    it 'parses data' do
      expect(subject.parsed_order).to
      eq(confirmed_on: DateTime.strptime('10/08/14 12:39', '%d/%m/%y %H:%M'),
         vendor_name: 'MAINTENANCE U.S.A.',
         line_items: [
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
         ],
         order_number: 12_345_678,
         po_number: '22551-1',
         status: 'pending',
         total: 713.79)
    end
  end
end
