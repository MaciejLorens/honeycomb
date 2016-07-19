class Api::V1::ResourcesController < ApplicationController
  before_action :set_resource, only: [:history]

  def index
    @resources = Resource.all
  end

  def history
    @audits = @resource.audits
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

end
