require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "to validate name presence"
    it 'save products successfully' do
      category = Category.create(name: 'Plants')
      product = Product.new(
        name: "Randy",
        price: 400,
        quantity: 12,
        category: category
      )

      expect(product.save).to eq(true)
    end
    
    it 'validates name presence' do
      product = Product.new
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")  
    end
    
    it 'validates price presence' do
      product = Product.new
      product.valid?
      expect(product.errors[:price]).to include("can't be blank") 
    end
    
    it 'validates quantity presence' do
      product = Product.new
      product.valid?
      expect(product.errors[:quantity]).to include("can't be blank")  
    end
    
    it 'validates category presence' do
      product = Product.new
      product.valid?
      expect(product.errors[:category]).to include("can't be blank")  
    end
    
  end
end



# describe StringCalculator do

#   describe ".add" do
#     context "to numbers" do
#       context "given '2,4'" do
#         it "returns 6" do
#           expect(StringCalculator.add("2,4")).to eql(6)
#       end
#     end

#     context "given '17,100'" do
#       it "returns 117" do
#         expect(StringCalculator.add("17,100")).to eql(117)
#       end
#     end
#   end
# end
# end