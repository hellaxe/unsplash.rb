class ImagesController < ApplicationController
  def random
    service = ImageService.new(params)
    image = service.random_image

    send_data image.to_blob, type: 'image/jpeg', disposition: 'inline'
  end

  def file_upload
    images = params[:file].values.map do |f|
      Image.create(image: f)
    end
    render json: {status: :ok, items: images.map(&:id)}
  end
end