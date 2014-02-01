module ShoppingList
  class Vendor
    attr_reader :name

    def initialize(name_str, price_range_str)
      @name = name_str.strip
      low, high = price_range_str.split('-')
      @low = string_to_int(low)
      @high = string_to_int(high)
    end

    def test(int_str)
      int = string_to_int(int_str)
      int.between?(@low, @high)
    end

    private
      def string_to_int(str)
        str.gsub(/\D/,'').to_i
      end

  end
end
