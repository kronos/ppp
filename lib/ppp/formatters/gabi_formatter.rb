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
          result[k] = "<#{v.class.to_s}> [#{v.strftime("%d/%m/%y %H:%M")}]"
        when Array
          result["#{k} <#{v.class.to_s}>"] = v.map {|e| GabiFormatter.new(e).formatted_text }
        else
          result[k] = "<#{v.class.to_s}> #{v}"
        end
      end

      result
    end
  end
end
