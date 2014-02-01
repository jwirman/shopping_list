module ShoppingList
  class Shop
    attr_reader :continue

    def initialize(vendors_file)
      @continue = true
      @vendors = []
      vendors_file.each_line do |line|
        name, range = line.split(':')
        @vendors << ShoppingList::Vendor.new(name, range)
      end
    end

    def go_shopping
      print "enter low price in dollars: "
      low = gets
      print "enter high price in dollars: "
      high = gets
      print 'Your shopping list: '
      puts @vendors.select{ |v| v.test(low) or v.test(high) }.map(&:name)
      print "again? (y|n) "
      again = gets
      @continue = false if again.chomp == 'n'
    end

  end
end
