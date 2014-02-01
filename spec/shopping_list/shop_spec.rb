require 'spec_helper'

module ShoppingList

  describe Shop do

    it 'sets up an empty shop' do
      file = double('file', each_line: '')
      shop = Shop.new(file)
      expect(shop.continue).to be_true
    end

    it 'sets up a shop with a vendor' do
      file = double('file')
      file.stub(:each_line).and_yield("company 123: $100-$2,000\n")
      Vendor.should_receive(:new).once.with("company 123", " $100-$2,000\n")
      shop = Shop.new(file)
      expect(shop.continue).to be_true
    end

    context 'shopping for vendors' do

      before(:each) do
        file = double('file')
        file.stub(:each_line).and_yield("company 1: $100-$2,000\n")
                             .and_yield("company 2: $1,000-$6,000\n")
                             .and_yield("company 3: $5,000-$8,000\n")
        @shop = Shop.new(file)
        @shop.stub(:print)
      end

      it 'does not get any vendors' do
        @shop.should_receive(:gets).exactly(3).times
             .and_return('$10', '$50', 'n')
        @shop.should_receive(:puts).once.with []
        @shop.go_shopping
      end

      it 'gets vendors based on low value' do
        @shop.should_receive(:gets).exactly(3).times
             .and_return('$150', '', 'n')
        @shop.should_receive(:puts).once.with ['company 1']
        @shop.go_shopping
      end

      it 'gets vendors based on high value' do
        @shop.should_receive(:gets).exactly(3).times
             .and_return('', '$6,000', 'n')
        @shop.should_receive(:puts).once.with ['company 2', 'company 3']
        @shop.go_shopping
      end

      it 'gets vendors based on both high and low values' do
        @shop.should_receive(:gets).exactly(3).times
             .and_return('$150', '$6,000', 'n')
        @shop.should_receive(:puts).once.with ['company 1', 'company 2', 'company 3']
        @shop.go_shopping
      end

    end

  end

end
