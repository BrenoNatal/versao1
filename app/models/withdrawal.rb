class Withdrawal < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validate :account_id, :amount, :validate_withdrawal

  def validate_withdrawal
    account = Account.where(id: account_id)[0]
    puts account.balance

    if ! account.vip?
      if amount > 1000 || amount > account.balance
        errors.add(:amount, "Valor maior que o permitido")
      end
    end
  end
end
