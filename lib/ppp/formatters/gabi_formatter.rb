module PPP
  class GabiFormatter
    def initialize(hash)
      @hash = hash
    end

    def formatted_text
      result = {}
      @hash.each do |k, v|
        case v
        when DateTime
          result[k] = "<#{v.class}> [#{v.strftime('%d/%m/%y %H:%M')}]"
        when Array
          result["#{k} <#{v.class}>"] = v.map do |e|
            GabiFormatter.new(e).formatted_text
          end
        else
          result[k] = "<#{v.class}> #{v}"
        end
      end

      result
    end
  end
end
