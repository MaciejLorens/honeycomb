class Api::V1::ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :history]

  def index
    @resources = Resource.all.order(created_at: :asc)
  end

  def show
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

end
