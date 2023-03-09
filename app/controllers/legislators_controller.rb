class LegislatorsController < ApplicationController
  require 'csv'
  before_action :set_legislator, only: %i[ show edit update destroy ]

  def import
    file = params[:file]
    return redirect_to legislators_path, notice: "Please upload only CSV" unless file.content_type == "text/csv"

    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    csv.each do |row|
      legislator = row["id,name"].split(",", 2)

      legislator_hash = {}
      legislator_hash[:id] = legislator[0].to_i
      legislator_hash[:name] = legislator[1]
      legislator_hash[:num_supported_bills] = 0
      legislator_hash[:num_opposed_bills] = 0

      Legislator.create(legislator_hash)
    end

    redirect_to legislators_path, notice: "Legislators imported"
  end

  def index
    @legislators = Legislator.all

    respond_to do |format|
      @legislators.each do |legislator|
        @supported_count = VoteResult.where("legislator_id == ? AND vote_type == ?", legislator[:id], 1).count
        @opposed_count = VoteResult.where("legislator_id == ? AND vote_type == ?", legislator[:id], 2).count

        legislator[:num_supported_bills] = @supported_count
        legislator[:num_opposed_bills] = @opposed_count
        legislator.save
      end

      format.html
      format.csv { send_data @legislators.to_csv }
    end
  end

  # GET /legislators/1 or /legislators/1.json
  def show
  end

  # GET /legislators/new
  def new
    @legislator = Legislator.new
  end

  # GET /legislators/1/edit
  def edit
  end

  # POST /legislators or /legislators.json
  def create
    @legislator = Legislator.new(legislator_params)

    respond_to do |format|
      if @legislator.save
        format.html { redirect_to legislator_url(@legislator), notice: "Legislator was successfully created." }
        format.json { render :show, status: :created, location: @legislator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @legislator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /legislators/1 or /legislators/1.json
  def update
    respond_to do |format|
      if @legislator.update(legislator_params)
        format.html { redirect_to legislator_url(@legislator), notice: "Legislator was successfully updated." }
        format.json { render :show, status: :ok, location: @legislator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @legislator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legislators/1 or /legislators/1.json
  def destroy
    @legislator.destroy

    respond_to do |format|
      format.html { redirect_to legislators_url, notice: "Legislator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def legislator_params
      params.require(:legislator).permit(:id, :name)
    end
end
