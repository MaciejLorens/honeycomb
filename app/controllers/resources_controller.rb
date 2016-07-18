class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :history, :update, :destroy]

  def index
    @resources = Resource.all
  end

  def show
  end

  def edit
  end

  def history
    @revisions = @resource.revisions
  end

  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      dur_params = params[:duration]
      duration = "#{dur_params[:days]}:#{dur_params[:hours]}:#{dur_params[:minutes]}:#{dur_params[:seconds]}"
      params.require(:resource).permit(:title, :episode, :year, :duration, :aspect_ratio).merge(duration: duration)
    end
end