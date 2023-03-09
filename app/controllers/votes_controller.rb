class VotesController < ApplicationController
  require 'csv'
  before_action :set_vote, only: %i[ show edit update destroy ]

  def import
    file = params[:file]
    return redirect_to votes_path, notice: "Please upload only CSV" unless file.content_type == "text/csv"

    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    csv.each do |row|
      vote = row["id,bill_id"].split(",", 2)

      vote_hash = {}
      vote_hash[:id] = vote[0].to_i
      vote_hash[:bill_id] = vote[1].to_i

      Vote.create(vote_hash)
    end

    redirect_to votes_path, notice: "Votes imported"
  end

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes or /votes.json
  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:id, :bill_id)
    end
end
