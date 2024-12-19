class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)


    if Account.exists?(account_num: @transaction.target_name)
      @transaction.account_id_target = Account.where(account_num: @transaction.target_name)[0].id
    else
      @transaction.account_id_target = -1
    end

    respond_to do |format|
      if @transaction.save

        account_target = Account.where(account_num: @transaction.target_name)[0]
        account_source = Account.where(account_num: @transaction.source_name)[0]

        account_target.balance = account_target.balance + @transaction.amount
        account_source.balance = account_source.balance - @transaction.amount

        if account_source.vip
          @transaction.fee = (@transaction.amount * 0.8)
          account_source.balance = account_source.balance - (@transaction.amount * 0.8)
        else
          @transaction.fee = 8
          account_source.balance = account_source.balance -  8
        end

        @transaction.save

        account_target.save
        account_source.save

        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.expect(transaction: [ :amount, :target_name, :source_name, :account_id_source, :account_id_target ])
    end
end