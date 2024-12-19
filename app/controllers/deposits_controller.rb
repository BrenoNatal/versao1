class DepositsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_deposit, only: %i[ show  ]

  # GET /deposits or /deposits.json
  def index
    @deposits = Deposit.all
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # POST /deposits or /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    account = Account.where(id: @deposit.account_id)[0]

    account.balance = account.balance + @deposit.amount
    account.save

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to deposits_path, notice: "Deposit was successfully created." }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.expect(deposit: [ :amount, :account_id ])
    end
end
