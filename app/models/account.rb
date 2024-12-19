class Account < ApplicationRecord
  attr_accessor :login

  before_validation :set_defaults
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deposits
  has_many :withdrawals

  has_many :transactions_source, class_name: "Transactions", foreign_key: "account_id_source"
  has_many :transactions_target, class_name: "Transactions", foreign_key: "account_id_target"


  validates :account_num, uniqueness: true, length: { is: 5 }

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where([ "account_num = :value",
      { value: login.strip. downcase } ]).first
  end

  def reduce_balance!
    return unless balance.negative?

    # Reduz 0.1% do saldo
    self.balance *= 0.999
    save!
  end

  # Verifica se o saldo foi suficiente para cobrir o negativo
  def balance_positive?
    balance >= 0
  end

  def set_defaults
    self.balance = 0 if self.balance.blank?
  end
end
