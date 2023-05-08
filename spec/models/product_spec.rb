require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do
      @category = Category.create(name: 'Test Category')
    end

    before(:each) do
      @product = @category.products.new(
        name: 'Test Product',
        price_cents: 1000,
        quantity: 5
      )
    end

    after(:all) do
      @category.destroy
    end

    describe 'product with all four fields set' do
      it 'saves successfully' do
        expect(@product).to be_valid
        expect { @product.save }.to change { Product.count }.by(1)
      end
    end

    describe 'name validation' do
      it 'is not valid without a name' do
        @product.name = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'price validation' do
      it 'is not valid without a price' do
        @product.price_cents = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
      end
    end

    describe 'quantity validation' do
      it 'is not valid without a quantity' do
        @product.quantity = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'category validation' do
      it 'is not valid without a category' do
        @product.category = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end