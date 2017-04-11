require 'ppp/parsers/line_items_parser'
require 'time'

module PPP
  class OrderConfirmationParser
    class InvalidReceiptFormat < TypeError; end

    def initialize(text)
      @text = text
    end

    def parsed_order
      {confirmed_on: confirmed_on,
       vendor_name:  vendor_name,
       order_number: order_number,
       status:       status,
       po_number:    po_number,
       line_items:   line_items,
       total:        total}
    rescue TypeError
      raise InvalidReceiptFormat.new
    end

  private
    def confirmed_on
      DateTime.strptime(raw_confirmed_on, "%d/%m/%y %H:%M")
    end

    def vendor_name
      @text.scan(/PAGE\s\d+\n\n(.+)\n\nCUSTOMER\sNAME/).flatten.first
    end

    def order_number
      @text.scan(/ORDER\sNUMBER\s:\s(\d+)$/).flatten.first
    end

    def status
      @text.scan(/STATUS\s:\s(\S+)$/).flatten.first.downcase
    end

    def po_number
      @text.scan(/^PURCHASE\sORDER\sNUMBER\s:\s(\S+)$/).flatten.first.downcase
    end

    def line_items
      LineItemsParser.new(raw_line_items).parsed_line_items
    end

    def total
      @text.scan(/TOTAL\sQTY\s:\s+\d+\sNET\s+([0-9\.]+)$/).flatten.first.to_f
    end

    def raw_confirmed_on
      @text.scan(/([\/0-9]+\s[0-9:]+)\s+ORDER\sDETAIL\sSUMMARY/).flatten.first
    end

    def raw_line_items
      @text.scan(/----------\n(.+)----------\nTOTAL\sLINES/m).flatten.first
    end
  end
end
