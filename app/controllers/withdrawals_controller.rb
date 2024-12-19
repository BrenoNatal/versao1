class WithdrawalsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_withdrawal, only: %i[ show]

  # GET /withdrawals or /withdrawals.json
  def index
    @withdrawals = Withdrawal.all
  end

  # GET /withdrawals/1 or /withdrawals/1.json
  def show
  end

  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
  end

  # POST /withdrawals or /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(withdrawal_params)

    account = Account.where(id: @withdrawal.account_id)[0]

    account.balance = account.balance - @withdrawal.amount
    account.save

    respond_to do |format|
      if @withdrawal.save
        format.html { redirect_to withdrawals_path, notice: "Withdrawal was successfully created." }
        format.json { render :show, status: :created, location: @withdrawal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdrawal
      @withdrawal = Withdrawal.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def withdrawal_params
      params.expect(withdrawal: [ :amount, :account_id ])
    end
end
