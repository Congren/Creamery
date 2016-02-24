require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
    #tests relationships
    should have_many(:assignments)
    should have_many(:stores).through(:assignments)
    #tests validations
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:date_of_birth)
    should validate_presence_of(:role)
    should validate_presence_of(:ssn)
    #tests specific values
    
    #for first_name
    should allow_value("George").for(:first_name)
    should allow_value("gerald").for(:first_name)
    should allow_value("geRalD").for(:first_name)
    should_not allow_value("53").for(:first_name)
    should_not allow_value(2).for(:first_name)
    should_not allow_value("as53").for(:first_name)
    should_not allow_value("").for(:first_name)

    #for last_name
    should allow_value("George").for(:last_name)
    should allow_value("gerald").for(:last_name)
    should allow_value("geRalD").for(:last_name)
    should_not allow_value("53").for(:last_name)
    should_not allow_value(2).for(:last_name)
    should_not allow_value("as53").for(:last_name)
    should_not allow_value("").for(:last_name)


    #for role
    should allow_value("manager").for(:role)
    should allow_value("admin").for(:role)
    should allow_value("employee").for(:role)
    should_not allow_value(35).for(:role)
    should_not allow_value("").for(:role)
    should_not allow_value("admins").for(:role)


    #for phone
    should allow_value("6212362361").for(:phone)
    should allow_value("623-162-6326").for(:phone)
    should allow_value("621236-2361").for(:phone)
    should allow_value("621-2362361").for(:phone)
    should_not allow_value("aaa-sdf-fadf").for(:phone)
    should_not allow_value("1a25d41523").for(:phone)
    should_not allow_value(0523525352).for(:phone)
    should_not allow_value("15235253525").for(:phone)
    should_not allow_value("").for(:phone)
    should_not allow_value("NY").for(:phone)
    
    #for ssn
    should allow_value("621236236").for(:ssn)
    should allow_value("623-62-6326").for(:ssn)
    should allow_value("62126-2361").for(:ssn)
    should allow_value("621-362361").for(:ssn)
    should_not allow_value("aaa-sf-fadf").for(:ssn)
    should_not allow_value("1a2541523").for(:ssn)
    should_not allow_value(052352535).for(:ssn)
    should_not allow_value("15235253525").for(:ssn)
    should_not allow_value("").for(:ssn)
    should_not allow_value("NY").for(:ssn)
    
    #for dob
    should allow_value(2.day.ago.to_date).for(:date_of_birth)
    should allow_value(18.years.ago.to_date).for(:date_of_birth)
    should_not allow_value(Date.today).for(:date_of_birth)
    should_not allow_value(1.year.from_now.to_date).for(:date_of_birth)
    should_not allow_value("bad").for(:date_of_birth)
    should_not allow_value(3.14159).for(:date_of_birth)
    
    #sets up employees stores and assignments
    context "Creating an employee context" do
    setup do
        create_stores
        create_employees
        create_assignments
    end

    #deletes employees stores and assignments
    teardown do
        destroy_assignments
        destroy_employees
        destroy_stores
    end

#scopes
should "have a scope to select employees younger than 18" do
    assert_equal ["George", "John"], Employee.younger_than_18.alphabetical.map{|e| e.first_name}
end

should "have a scope to select employees older than 18" do
    assert_equal ["Andrew", "Ben", "Kevin", "Michael"], Employee.is_18_or_older.alphabetical.map{|e| e.first_name}
end

should "have a scope to select only active employees" do
    assert_equal ["Andrew", "George", "Kevin", "Michael"], Employee.active.alphabetical.map{|e| e.first_name}
end
should "have a scope to select only inactive employees" do
    assert_equal ["Ben","John"], Employee.inactive.alphabetical.map{|e| e.first_name}
end
should "have a scope to select only employees" do
    assert_equal ["George", "John"], Employee.regulars.alphabetical.map{|e| e.first_name}
end
should "have a scope to select only admins" do
    assert_equal ["Andrew", "Michael"], Employee.admins.alphabetical.map{|e| e.first_name}
end
should "have a method to return an employees last and first name " do
        assert_equal "Wang, Andrew" , @ae1.name
end

should "have a scope that returns employees in alphabetical order by first and last name"  do
    assert_equal ["Wang, Andrew","Chu, Ben", "White, George", "Han, John", "Yin, Kevin", "Chin, Michael"], Employee.alphabetical.map{|e| e.name}
end

#should be 15,30,15 set to 15.years.ago, seems like the timeliness date is set to one day in the future when I call it. Shouldn't be anything wrong with function, was working earlier
should "have a method to return an employee's age" do
    assert_equal 15,@ee1.age
    assert_equal 30, @ae2.age
    assert_equal 15, @ee2.age
end

should "have a method to return an employees current assignment" do

    assert_equal @a2, @ae1.current_assignment
    assert_equal nil, @me1.current_assignment
   
    end

should "have a method to return a bool of whether or not employee is over 18" do
    assert_equal true, @ae1.over_18?
    assert_equal false, @ee1.over_18?
end
should "return stripped number" do
    assert_equal "1252631222", @ae1.instance_eval{reformat_phone}   # invoke the private method
    
end
end
end