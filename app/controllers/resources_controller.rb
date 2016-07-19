class ResourcesController < ApplicationController
  before_action :set_resource, only: [:edit, :history, :update, :destroy]

  def index
    @resources = Resource.all
  end

  def edit
  end

  def history
    @revisions = @resource.revisions
  end

  def update
    if @resource.update(resource_params)
      redirect_to resources_url, notice: 'Resource was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: 'Resource was successfully destroyed.'
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
