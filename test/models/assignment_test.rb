require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
    #relationships
    should belong_to(:store)
    should belong_to(:employee)
    
    #validations
    should validate_presence_of(:store_id)
    should validate_presence_of(:employee_id)
    should validate_presence_of(:start_date)
    should validate_presence_of(:pay_level)
    
    #checks specific values
    
    #checks for pay_level
    should allow_value(0).for(:pay_level)
    should allow_value(4).for(:pay_level)
    should_not allow_value("s").for(:pay_level)
    should_not allow_value(-2).for(:pay_level)
    should_not allow_value("").for(:pay_level)
    
    #checks for store_id
    should_not allow_value(0).for(:store_id)
    should allow_value(4).for(:store_id)
    should_not allow_value("s").for(:store_id)
    should_not allow_value(-2).for(:store_id)
    should_not allow_value("").for(:store_id)
    
    #checks for employee_id
    should_not allow_value(0).for(:employee_id)
    should allow_value(4).for(:employee_id)
    should_not allow_value("s").for(:employee_id)
    should_not allow_value(-2).for(:employee_id)
    should_not allow_value("").for(:employee_id)
    
    #checks for start_date
    should allow_value(1.year.ago.to_date).for(:start_date)
    should_not allow_value(1.year.from_now.to_date).for(:start_date)
    
    
    #creates stores employees and assignments
    context "Creating a set of chores" do
    setup do
        create_stores
        create_employees
        create_assignments
    end

    #destroys stores employees and assignments
    teardown do
        destroy_assignments
        destroy_employees
        destroy_stores
    end
#the pay level for all the assignments are different so we will use that as a basis to see whether or not returned values are correct
should "show assignments for a store ordered by store name" do
    assert_equal [ 1, 1, 1, 3, 3, 3, 4, 4 ] , Assignment.by_store.map{|a| a.store_id}
end

should "show all current assignments" do
    assert [ 3,5,8,9 ] , Assignment.current.by_pay_level.map{|a| a.pay_level}
end

should "order assignments by pay_level" do
    assert_equal [ 2,3,4,5,6,7,8,9 ] , Assignment.by_pay_level.map{|a| a.pay_level}
end

should "selects all assignments of a certain pay_level" do
    assert_equal [ 9 ] , Assignment.for_pay_level(9).map{|a| a.pay_level}
end

should "Selects all the assignments for a certain employee" do
    assert_equal [ 1, 1 ], Assignment.for_employee(1).map{|a| a.employee_id}
end

should "Selects all the assignments for a certain store" do
    assert_equal [ 3,3,3 ] , Assignment.for_store(3).map{|a| a.store_id}
end

should "We will be testing it by making sure that both employee and store are active for a assignment given, However, it will be used to validate creations" do
    assert_equal true, @me1.active
    assert_equal true, @WestV.active
    assert_equal false, @a6.instance_eval{check_valid}
    assert_equal true, @a5.instance_eval{check_valid}
end

should "Ends an employees previous assignment when given a new one " do
    @a7.instance_eval{end_previous_methods}
    assert_equal "Tue, 22 Dec 2015".to_date , @a7.start_date

end
end
end