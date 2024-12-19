class HomeController < ApplicationController
  def index
    if account_signed_in?
      account = current_account
      @list_deposits =  account.deposits
      @list_withdrawals = account.withdrawals
      @list_transactions = Transaction.where("account_id_target = ?", account.id).or(Transaction.where("account_id_source = ?", account.id))
    end
  end
end
