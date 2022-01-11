require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category= Category.create!(name: "category1")
    @product = Product.new(name: 'chair', price_cents: 3000, quantity: 3, category: @category)
  end
  describe 'Validations' do
    it 'should be valid with valid atributes' do 
      @product.save
      expect(@product).to be_valid
    end
    
    it 'should not be valid without a name' do
      @product.name = nil
      @product.save
      expect(@product).to_not be_valid
    end
    it 'should not be valid without a price' do
      # byebug
      @product.price_cents = nil
      @product.save
      expect(@product).to_not be_valid
    end
    it 'should not be valid without a quantity' do
      @product.quantity = nil
      @product.save
      expect(@product).to_not be_valid
    end
    it 'should not be valid without a category' do
      @product.category = nil
      @product.save
      expect(@product).to_not be_valid
    end
    
  end
end


