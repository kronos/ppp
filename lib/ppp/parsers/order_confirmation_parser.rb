require 'ppp/parsers/line_items_parser'
require 'time'

module PPP
  class OrderConfirmationParser
    class UnknownReceiptFormat < TypeError; end

    def initialize(text)
      @text = text
    end

    def parsed_order
      @counter = 0

      {
        confirmed_on: confirmed_on,
        vendor_name:  vendor_name,
        order_number: order_number,
        status:       status,
        po_number:    po_number,
        line_items:   line_items,
        total:        total
      }
    rescue StandardError
      raise UnknownReceiptFormat
    end

    private

    def confirmed_on
      DateTime.strptime(raw_confirmed_on, '%d/%m/%y %H:%M')
    end

    def vendor_name
      retrieve_data("\n\n", "\n\n")
    end

    def order_number
      retrieve_data('ORDER NUMBER : ', "\n").to_i
    end

    def status
      retrieve_data('STATUS : ', "\n").downcase
    end

    def po_number
      retrieve_data('ORDER NUMBER : ', "\n")
    end

    def line_items
      LineItemsParser.new(raw_line_items).parsed_line_items
    end

    def total
      total_start  = @text.index(/\d+\.\d+$/, @counter)
      total_finish = @text.index("\n\n", total_start)
      @text[total_start...total_finish].to_f
    end

    def raw_confirmed_on
      idx = @text.index(%r{^\d{2}\/\d{2}\/\d{2}}, @counter)
      @counter = idx + 14
      @text[idx...@counter]
    end

    def raw_line_items
      retrieve_data("----------\n", '-------').strip
    end

    def retrieve_data(from, to)
      start  = @text.index(from, @counter) + from.length
      finish = @text.index(to, start)
      @counter = finish + to.length
      @text[start...finish]
    end
  end
end
