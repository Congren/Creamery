class Employee < ActiveRecord::Base
    #removes dashes from phone number before saving
    before_save :reformat_phone
    
    #defines relationships
    has_many :assignments
    has_many :stores, through: :assignments
    
    #validations
    
    #validates presences
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :date_of_birth
    validates_presence_of :role
    validates_presence_of :ssn
    
    #makes sure first and last names don't have numbers in them
    validates_format_of :first_name, :with => /\A[A-Za-z]+\Z/, :message => "no numbers allowed"
    validates_format_of :last_name, :with => /\A[A-Za-z]+\Z/, :message => "no numbers allowed"
    
    #makes sure dob is before today
    validates_date :date_of_birth, :before => lambda { Date.today },
    :before_message => "must be a date before today"
    
    #makes sure role is a valid role "admin employee or manager"
    validates_inclusion_of :role, in: %w[admin employee manager], message: "Please choose either admin, employee, or manager (lowercase)"
    
    #makes phone number format either 6316236233, or also allows dashes after the 3rd  or 6th digit. ex: 631-623-6233, 631-6236233 or 631623-6233. Needs area code
    validates :phone, format: { with: /\A[0-9]\d{2}-?\d{3}-?\d{4}\Z/, message: "only 10 digits with or without dashes ex: 323-423-4692 or 3234234692" }
    
    #ssn is 252-23-1525 or 252231523 format
    validates :ssn, format: { with: /\A[0-9]\d{2}-?\d{2}-?\d{4}\Z/,
    message: "only 10 digits with or without dashes ex 235-32-1522 or 235321522" }
    
    #creates scopes
    scope :younger_than_18, -> { where("date_of_birth > ?", 18.years.ago ) }
    scope :is_18_or_older, -> { where("date_of_birth <= ?", 18.years.ago ) }
    scope :active, -> {where(active: true)}
    scope :inactive, -> {where(active: false)}
    scope :regulars, -> {where("role = ?", 'employee')}
    scope :managers, -> {where("role = ?", 'manager')}
    scope :admins, -> {where("role = ?", 'admin')}
    scope :alphabetical, -> {order('first_name, last_name')}
    
    #methods
    
    def name
        last_name + ", " + first_name
    end
    
    def age
        age = Date.today.year - date_of_birth.to_date.year
        age -= 1 if Date.today < date_of_birth + age.years
        age
    end
    
    def over_18?
        age = Date.today.year - date_of_birth.to_date.year
        age -= 1 if Date.today < date_of_birth + age.years
        age >= 18
    end
    
    def current_assignment
        assignments = Assignment.current.map{|assignment| assignment}
        assignments.each do |assignment|
            if assignment.employee_id == self.id
                return assignment
            else
                return nil
            end
        end
    end
    
    private
    #taken from pats
    # We need to strip non-digits before saving to db
    def reformat_phone
        phone = self.phone.to_s  # change to string in case input as all numbers
        phone.gsub!(/[^0-9]/,"") # strip all non-digits
        self.phone = phone       # reset self.phone to new string
    end
end
