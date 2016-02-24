require 'test_helper'

class StoreTest < ActiveSupport::TestCase
    #checks relationships
    should have_many(:assignments)
    should have_many(:employees).through(:assignments)
    #checks validations
    should validate_presence_of(:name)
    should validate_presence_of(:street)
    should validate_presence_of(:zip)
    should validate_uniqueness_of(:name)
    #checks specific values
    
    #for state
    should allow_value("PA").for(:state)
    should allow_value("OH").for(:state)
    should allow_value("WV").for(:state)
    should_not allow_value("NY").for(:state)
    should_not allow_value(2).for(:state)
    should_not allow_value("").for(:state)
    
    #for zip
    should allow_value("00000").for(:zip)
    should allow_value("15278").for(:zip)
    should_not allow_value("125333").for(:zip)
    should_not allow_value("152as").for(:zip)
    should_not allow_value("1253").for(:zip)
    should_not allow_value(02522).for(:zip)
    should_not allow_value("").for(:zip)
    
    #for phone
    should allow_value("6212362361").for(:phone)
    should allow_value("623-162-6326").for(:phone)
    should_not allow_value(0235253525).for(:phone)
    should allow_value("621236-2361").for(:phone)
    should allow_value("621-2362361").for(:phone)
    should_not allow_value("aaa-sdf-fadf").for(:phone)
    should_not allow_value("1a25d41523").for(:phone)
    should_not allow_value("15235253525").for(:phone)
    should_not allow_value("").for(:phone)
    should_not allow_value("NY").for(:phone)
    
    #creates stores
    context "Creating a store context" do
    setup do
        create_stores
    end

    #destroys stores
    teardown do
        destroy_stores
    end

#checks scopes
should "have a scope to select only active stores" do
    assert_equal ["CMU Eats","Ohio Eats","WestV Eats"], Store.active.alphabetical.map{|s| s.name}
    assert_equal 3, Store.active.alphabetical.size
end

should "have a scope to alphabetize stores" do
    assert_equal ["CMU Eats", "Ohio Eats", "Pitt Eats", "WestV Eats"], Store.alphabetical.map{|s| s.name}
end

should "have a scope to select only inactive stores" do
    assert_equal ["Pitt Eats"], Store.inactive.alphabetical.map{|s| s.name}
end
should "return stripped number" do
    assert_equal "2312533255", @Ohio.instance_eval{reformat_phone}   # invoke the private method
end
end
end