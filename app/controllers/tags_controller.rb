class TagsController < ApplicationController
  def index
    if params[:q].present?
      @tags = Tag.ilike(params[:q])

      render json: {items: @tags.map { |t| {id: t.id, name: t.name } }}.to_json
    else
      @tags = Tag.all.page(params[:page])
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