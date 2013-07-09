require 'spec_helper'

describe Product do
  
  describe "product factories" do

  	it "should have a valid factory" do
  	  Fabricate.build(:product).should be_valid
  	end
  end

  describe "product database" do

  	it "should have columns name, code and description" do
  		@product = Product.new
  		model_has_columns(@product, :name, :code, :description)
  	end
  end

  describe "product validation" do

  	it "should require a name" do
  		Fabricate.build(:product, name: "").should_not be_valid
  	end

  	it "should require a code" do
  		Fabricate.build(:product, code: "").should_not be_valid
  	end
  end

end
