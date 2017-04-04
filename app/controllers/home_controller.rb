class HomeController < ApplicationController
  def index
    @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(10)
    @stats = StatsCollector.process
  end
end