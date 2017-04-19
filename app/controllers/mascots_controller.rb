class MascotsController < ApplicationController
  before_action :set_mascot, only: [:show, :edit, :update, :destroy]

  # GET /mascots
  # GET /mascots.json
  def index
    @mascots = Mascot.all
  end

  # GET /mascots/1
  # GET /mascots/1.json
  def show
  end

  # GET /mascots/new
  def new
    @mascot = Mascot.new
  end

  # GET /mascots/1/edit
  def edit
  end

  # POST /mascots
  # POST /mascots.json
  def create
    @mascot = Mascot.new(mascot_params)

    respond_to do |format|
      if @mascot.save
        format.html { redirect_to @mascot, notice: 'Mascot was successfully created.' }
        format.json { render :show, status: :created, location: @mascot }
      else
        format.html { render :new }
        format.json { render json: @mascot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mascots/1
  # PATCH/PUT /mascots/1.json
  def update
    respond_to do |format|
      if @mascot.update(mascot_params)
        format.html { redirect_to @mascot, notice: 'Mascot was successfully updated.' }
        format.json { render :show, status: :ok, location: @mascot }
      else
        format.html { render :edit }
        format.json { render json: @mascot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mascots/1
  # DELETE /mascots/1.json
  def destroy
    @mascot.destroy
    respond_to do |format|
      format.html { redirect_to mascots_url, notice: 'Mascot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mascot
      @mascot = Mascot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mascot_params
      params.require(:mascot).permit(:classification, :name)
    end
end
