require 'ppp/parsers/line_item_parser'

module PPP
  class LineItemsParser
    def initialize(items_text)
      @items_text = items_text
    end

    def parsed_line_items
      @items_text.split("\n\n").map do |item|
        LineItemParser.new(item.strip).parsed_line_item
      end
    end
  end
end
