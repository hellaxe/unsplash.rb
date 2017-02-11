class TaggingsController < ApplicationController

  def bulk_new
    render 'new'
  end

  def bulk_create
    BulkImageAssigner.process(params)

    redirect_to root_path
  end

end