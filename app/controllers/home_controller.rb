class HomeController < ApplicationController
  def index
    @tags = Tag.all.order(created_at: :desc).page(params[:page])
    @stats = StatsCollector.process
  end
end