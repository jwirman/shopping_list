require 'spec_helper'

module ShoppingList

  describe Vendor do

    it 'sets up a vendor properly' do
      Vendor.any_instance.should_receive(:string_to_int).twice
      vendor = Vendor.new('My Company  ', '$100 - $5,000\n')
      expect(vendor.name).to eq 'My Company'
    end

    context 'checks shoppers bid against a vendors range' do

      let(:vendor) { Vendor.new('company', '$100-$500') }

      it 'falls within vendor range' do
        expect(vendor.test('$200')).to be_true
      end

      it 'falls outside vendor range' do
        expect(vendor.test('$800')).to be_false
      end

      it 'falls within vendor range edge case' do
        expect(vendor.test('$500')).to be_true
      end

    end

  end

end
