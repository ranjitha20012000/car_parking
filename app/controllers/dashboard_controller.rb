class DashboardController < ApplicationController
  before_action :authenticate_user!
  def home
    @vehicles = Vehicle.all
  end
end
