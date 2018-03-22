class RestsController < ApplicationController
  def show
    @rest = Rest.find(params[:id])
  end
end
