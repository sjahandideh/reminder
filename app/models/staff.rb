class Staff < ActiveRecord::Base
  attr_accessible :email, :name, :payroll_number, :phone
  has_many :appointments, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :email => true
  validates :payroll_number, :numericality => true
end
