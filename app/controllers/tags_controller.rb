class TagsController < ApplicationController
  def index
    @tags =
      if params[:q].present?
        Tag.ilike(params[:q]).page(params[:page]).per(10)
      else
        Tag.all.page(params[:page]).per(10)
      end

    respond_to do |format|
      format.json { render json: { success: true, results: @tags.map {|t| { name: t.name, value: t.id } } }.to_json }
      format.html
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  protected
  def tag_params
    params.require(:tag).permit(:name, :virtual_aliases)
  end
end