class BillsController < ApplicationController
  require 'csv'
  before_action :set_bill, only: %i[ show edit update destroy ]

  def import
    file = params[:file]
    return redirect_to bills_path, notice: "Please upload only CSV" unless file.content_type == "text/csv"

    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    csv.each do |row|
      bill = row["id,title,sponsor_id"].split(',')
      p bill

      bill_hash = {}
      bill_hash[:id] = bill[0].to_i
      bill_hash[:title] = bill[1]
      bill_hash[:primary_sponsor_id] = bill[2].to_i
      bill_hash[:primary_sponsor_name] = ''
      bill_hash[:supporter_count] = 0
      bill_hash[:opposer_count] = 0

      Bill.create(bill_hash)
    end

    redirect_to bills_path, notice: "Bills imported"
  end


  def index
    @bills = Bill.all

    respond_to do |format|
      @bills.each do |bill|

        @sponsor = Legislator.where("id == ?", bill[:primary_sponsor_id]).first
        @votes = Vote.where("bill_id == ?", bill[:id]).first
        @supporter_results = VoteResult.where("vote_id == ? AND vote_type == ?", @votes[:id].to_i, 1).count
        @opposer_results = VoteResult.where("vote_id == ? AND vote_type == ?", @votes[:id].to_i, 2).count

        if !bill[:supporter_count] || (@supporter_results != 0)
          bill[:supporter_count] = @supporter_results
          bill.save
        end

        if !bill[:opposer_count] || (@opposer_results != 0)
          bill[:opposer_count] = @opposer_results
          bill.save
        end

        if bill[:primary_sponsor_name].empty? || ( @sponsor == nil)
          bill[:primary_sponsor_name] = "Name not found"
          bill.save
        else
          bill[:primary_sponsor_name] = @sponsor.name
          bill.save
        end
      end

      format.html
      format.csv { send_data @bills.to_csv }
    end
  end

  def show
  end

  def new
    @bill = Bill.new
  end

  def edit
  end

  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully created." }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully updated." }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:id, :title, :primary_sponsor_id)
    end
end
