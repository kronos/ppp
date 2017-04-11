module PPP
  class LineItemParser
    def initialize(text)
      @line_item = text.split("\n", 2).first.split(/\s+/)
    end

    def parsed_line_item
      {line_number: line_number,
       item_number: item_number,
       description: description,
       quantity:    quantity,
       unit_price:  unit_price}
    end

  private
    def line_number
      @line_item.first.to_i
    end

    def item_number
      @line_item[1].to_i
    end

    def description
      @line_item[2...-3].join(' ')
    end

    def quantity
      @line_item[-3].to_i
    end

    def unit_price
      @line_item[-1].to_f
    end
  end
end
