class Account < ApplicationRecord
  attr_accessor :login


  before_validation :set_defaults
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :account_num, uniqueness: true, length: { is: 5 }

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where([ "account_num = :value",
      { value: login.strip. downcase } ]).first
  end

  private

  def set_defaults
    self.balance = 0 if self.balance.blank?
  end
end
