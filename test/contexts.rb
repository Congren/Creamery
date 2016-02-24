module Contexts
    #initialize stores
  def create_stores
      
    @CMU = FactoryGirl.create(:store)
    
    @Pitt = FactoryGirl.create(:store, name: "Pitt Eats", phone: "6323221623", active: 0)
    
    @Ohio = FactoryGirl.create(:store, name: "Ohio Eats", street: "Wood Road", city: "Poli", state:"OH", zip: "17234", phone: "231-2533255")
    
    @WestV = FactoryGirl.create(:store, name: "WestV Eats", street: "Wow Ave", city: "Bush", state: "WV", zip:"09252", phone: "1523551235")
  end
  #destroys stores
  def destroy_stores
    @CMU.destroy
    @Pitt.destroy
    @Ohio.destroy
    @WestV.destroy
  end
  
 
 #initializes employees
  def create_employees
      
    @ae1 = FactoryGirl.create(:employee)
    
    @me1 = FactoryGirl.create(:employee, first_name: "Kevin", last_name: "Yin", ssn: "523231522", date_of_birth: 23.years.ago.to_date, phone: "5235123222", role: "manager")
    
    @ee1 = FactoryGirl.create(:employee, first_name: "George", last_name: "White", ssn: "252231523", date_of_birth: 15.years.ago.to_date, phone: "3203469783", role: "employee")
    
    @ae2 = FactoryGirl.create(:employee, first_name: "Michael", last_name: "Chin", ssn: "213231523", date_of_birth: 30.years.ago.to_date, phone: "9749234013", role: "admin")
    
    @me2 = FactoryGirl.create(:employee, first_name: "Ben", last_name: "Chu", ssn: "677524839", date_of_birth: 18.years.ago.to_date, phone: "4329731063", role: "manager", active: 0)
    
    @ee2 = FactoryGirl.create(:employee, first_name: "John", last_name: "Han", ssn: "294643279", date_of_birth: 15.years.ago.to_date, phone: "9472342734", role: "employee", active: 0)
  end
  
  #destroys employees
  def destroy_employees
    @ae1.destroy
    @me1.destroy
    @ee1.destroy
    @ae2.destroy
    @me2.destroy
    @ee2.destroy
  end
  
  #initializes assignments
  def create_assignments
      @a1 = FactoryGirl.create(:assignment, store: @CMU, employee: @ae1, end_date:Date.today.to_date)
      
      @a2 = FactoryGirl.create(:assignment, store: @CMU, employee: @ae1, start_date: Date.today.to_date, pay_level: 3)
      
      @a3 = FactoryGirl.create(:assignment, store: @Ohio, employee: @me1, start_date: 11.months.ago.to_date, end_date: 4.months.ago.to_date, pay_level: 4)
      
      @a4 = FactoryGirl.create(:assignment, store: @Ohio, employee: @ee1, start_date: 6.months.ago.to_date, pay_level: 5)
      
      @a5 = FactoryGirl.create(:assignment, store: @WestV, employee: @me1, start_date: 4.months.ago.to_date, end_date: Date.today.to_date, pay_level: 6)
      
      @a6 = FactoryGirl.create(:assignment, store: @WestV, employee: @ee2, start_date: 8.months.ago.to_date, end_date: 2.months.ago, pay_level: 7)
      
      @a7 = FactoryGirl.create(:assignment, store: @CMU, employee: @ee1, start_date: 2.months.ago.to_date, pay_level: 8)
      
      @a8 = FactoryGirl.create(:assignment, store: @Ohio, employee: @ae2, start_date: 2.months.ago.to_date, pay_level: 9)
  end
  
  #destroys assignments
  def destroy_assignments
      @a1.destroy
      @a2.destroy
      @a3.destroy
      @a4.destroy
      @a5.destroy
      @a6.destroy
      @a7.destroy
      @a8.destroy
  end
end