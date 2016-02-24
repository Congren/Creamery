class Assignment < ActiveRecord::Base
    #commented out callbacks as some prevent creation of test methods
    #before_save :check_valid
    #before_create :end_previous_methods
    #relationships
    belongs_to :employee
    belongs_to :store
    #validations
    validates_presence_of :store_id
    validates_presence_of :employee_id
    validates_presence_of :start_date
    validates_presence_of :pay_level
    
    validates_numericality_of :pay_level, :only_integer => true, :greater_than_or_equal_to => 0
    
    validates_date :start_date, :on_or_before => lambda { Date.today.to_date }
    
    


    #makes sure a non negative integer id is inputted
    validates_numericality_of :employee_id, :only_integer => true, :greater_than_or_equal_to => 1
    validates_numericality_of :store_id, :only_integer => true, :greater_than_or_equal_to => 1

    #scopes
    scope :by_store, -> {joins(:store).order("stores.name")}
    scope :current, -> { where('end_date is NULL') }
    scope :for_pay_level, -> (pay_level) {where('pay_level = ?', "#{pay_level}")}
    scope :by_pay_level, -> {order(:pay_level)}
    scope :for_employee, -> (employee_id) { joins(:employee).where('employees.id = ?', "#{employee_id}")}
    scope :for_store, -> (store_id) { joins(:store).where('stores.id = ?', "#{store_id}") }
    
    #checks if both employee and store are active
    private
    def check_valid
        inactive_employees=Employee.inactive.map{|e| e.id}
        inactive_stores=Store.inactive.map{|e| e.id}
        inactive_employees.each do |e|
            if e == self.employee_id
                return false
            end
        end
        inactive_stores.each do |s|
            if s == self.store_id
                return false
                end
            end
        return true
    end
    
    private
    def end_previous_methods
        open = Assignment.current.map {|current| current}
        open.each do |o|
            if o.employee_id = self.employee_id || o.end_date==nil
                o.end_date = self.start_date
                save!
            end
        end
    
    end
end
