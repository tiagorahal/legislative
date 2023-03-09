class VoteResultsController < ApplicationController
  require 'csv'
  before_action :set_vote_result, only: %i[ show edit update destroy ]

  def import
    file = params[:file]
    return redirect_to bills_path, notice: "Please upload only CSV" unless file.content_type == "text/csv"

    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    csv.each do |row|
      p row
      vote_result = row["id,legislator_id,vote_id,vote_type"].split(',')
      p vote_result

      vote_result_hash = {}
      vote_result_hash[:id] = vote_result[0].to_i
      vote_result_hash[:legislator_id] = vote_result[1].to_i
      vote_result_hash[:vote_id] = vote_result[2].to_i
      vote_result_hash[:vote_type] = vote_result[3].to_i

      VoteResult.create(vote_result_hash)
    end

    redirect_to vote_results_path, notice: "Vote Results imported"
  end

  # GET /vote_results or /vote_results.json
  def index
    @vote_results = VoteResult.all
  end

  # GET /vote_results/1 or /vote_results/1.json
  def show
  end

  # GET /vote_results/new
  def new
    @vote_result = VoteResult.new
  end

  # GET /vote_results/1/edit
  def edit
  end

  # POST /vote_results or /vote_results.json
  def create
    @vote_result = VoteResult.new(vote_result_params)

    respond_to do |format|
      if @vote_result.save
        format.html { redirect_to vote_result_url(@vote_result), notice: "Vote result was successfully created." }
        format.json { render :show, status: :created, location: @vote_result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_results/1 or /vote_results/1.json
  def update
    respond_to do |format|
      if @vote_result.update(vote_result_params)
        format.html { redirect_to vote_result_url(@vote_result), notice: "Vote result was successfully updated." }
        format.json { render :show, status: :ok, location: @vote_result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_results/1 or /vote_results/1.json
  def destroy
    @vote_result.destroy

    respond_to do |format|
      format.html { redirect_to vote_results_url, notice: "Vote result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_result
      @vote_result = VoteResult.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_result_params
      params.require(:vote_result).permit(:id, :legislator_id, :vote_id, :vote_type)
    end
end
