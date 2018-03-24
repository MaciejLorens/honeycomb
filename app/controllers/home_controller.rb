class HomeController < ApplicationController

  def index
    @resources = Resource.all.order(created_at: :asc)
  end

end
