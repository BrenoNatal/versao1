class ReduceBalanceJob < ApplicationJob
  queue_as :default

  def perform
    # Busca todas as contas com saldo negativo
    Account.where("balance < 0").find_each do |account|
      account.reduce_balance!
    end

    # Reagenda o job para rodar novamente em 1 minuto
    self.class.set(wait: 1.minute).perform_later
  end
end
