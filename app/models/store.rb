class Store < ActiveRecord::Base
    #strips other characters before saving phone number
    before_save :reformat_phone
    #defines relationships
    has_many :assignments
    has_many :employees, through: :assignments
    #validations
    #validates presences
    validates_presence_of :name
    validates_presence_of :street
    validates_presence_of :zip
    #makes sure city doesnt have numbers in it
    validates_format_of :city, :with => /\A[A-Za-z]+\Z/, :message => "should be a real city"
    #makes sure zip is a 5 number digit
    validates_format_of :zip, :with => /\A[0-9]\d{4}\Z/, :message => "should be in form ex: 15289"
    validates :name, uniqueness: true
    #checks for valid state (OH PA or WV)
    validates_inclusion_of :state, in: %w[OH PA WV], message: "Please choose either OH, PA, or WV (Uppercase)"
    #makes phone number format either 6316236233, or also allows dashes after the 3rd  or 6th digit. ex: 631-623-6233, 631-6236233 or 631623-6233. Needs area code
    validates :phone, format: { with: /\A[0-9]\d{2}-?\d{3}-?\d{4}\Z/,
    message: "only 10 digits with or without dashes" }
    #scopes
    scope :active, -> {where(active: true)}
    scope :inactive, -> {where(active: false)}
    scope :alphabetical, -> {order(:name)}
    private
    #taken from pats strips nondigit characters from phone
    def reformat_phone
        phone = self.phone.to_s  # change to string in case input as all numbers
        phone.gsub!(/[^0-9]/,"") # strip all non-digits
        self.phone = phone       # reset self.phone to new string
    end
end
