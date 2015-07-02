class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]



# GET /bike
def bike

  @client = Strava::Api::V3::Client.new(:access_token => "47f86ceb37abbe5fabb10ae20efeb926bcaa43f6")
  @all_bike_adventures = @client.list_athlete_activities

#Below I will go over this whole array to only show activities with Sharon as part of the name.
#ie. check the "name" string to see if a substring matches "Sharon"

#first, create an empty array 
@bike_adventures = []

#then iterate over my original array to find all relevant data and push it to my new array
@all_bike_adventures.each do |aspects|
  @my_string = aspects["name"]
  @my_string.downcase!

  if @my_string.include? "sharon"
      @bike_adventures.push aspects 
  end

end


end


  # GET /adventures
  # GET /adventures.json
  def index

    @adventures = Adventure.all

   #This doesn't work: @all_adventures=@adventures.merge(@bike_adventures)

  end

  # GET /adventures/1
  # GET /adventures/1.json
  def show
  end

  # GET /adventures/new
  def new
    @adventure = Adventure.new
  end

  # GET /adventures/1/edit
  def edit
  end

  # POST /adventures
  # POST /adventures.json
  def create
    @adventure = Adventure.new(adventure_params)

  #establish relevant API data (see 'bike' method for notes)
      @client = Strava::Api::V3::Client.new(:access_token => "47f86ceb37abbe5fabb10ae20efeb926bcaa43f6")
      @all_bike_adventures = @client.list_athlete_activities

      @bike_adventures = []

      @all_bike_adventures.each do |aspects|
  
        @my_string = aspects["name"]
        @my_string.downcase!

        if @my_string.include? "sharon"
          @bike_adventures.push aspects 
        end

      end


#another set of filtering 1 set that corresponds to a loop that checks for another pattern that you match on datetime

    @bike_adventures.each do |aspects|

      @match_date = Date.parse(aspects["start_date"])
      @match_date = @match_date.strftime('%a, %d %b %Y')


      if @match_date === @adventure.date.strftime('%a, %d %b %Y')
          @adventure.activity = "Biking"
          @adventure.misc_notes = aspects["name"] 
          @adventure.duration = aspects["moving_time"]
          @adventure.date = aspects["start_date"]
        @adventure.save
        break
      end
    end


    respond_to do |format|
      if @adventure.save
        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render :show, status: :created, location: @adventure }
      else
        format.html { render :new }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adventures/1
  # PATCH/PUT /adventures/1.json
  def update
    respond_to do |format|
      if @adventure.update(adventure_params)
        format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
        format.json { render :show, status: :ok, location: @adventure }
      else
        format.html { render :edit }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure.destroy
    respond_to do |format|
      format.html { redirect_to adventures_url, notice: 'Adventure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventure
      @adventure = Adventure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adventure_params
      params.require(:adventure).permit(:activity, :date, :duration, :maps, :misc_notes)
    end
#how to create a new date object date.new = "string that is a date" should be formatted a certain way. I might have to go into the string and exclude certain characters.

end

