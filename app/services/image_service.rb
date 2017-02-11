class ImageService
  DIR_PATH = 'public/uploads/cache/images'

  def initialize(params)
    @params = normalize_params params
  end

  def random_image
    image = get_image

    with_cache(image) do
      Rails.logger.info("=================== #{image.id}===================")
      img_file = image.image.file.file
      mm_file = MiniMagick::Image.open(img_file)

      resize(mm_file)

      mm_file
    end
  end

  protected

  def get_image
    if @params[:category]
      tag = Tag.ilike(@params[:category]).first

      if tag.present?
        return tag.images.order('RANDOM()').first
      end
    end

    Image.order('RANDOM()').first
  end

  def with_cache(image, perform_cache = true, &block)
      if perform_cache
        cached_file = try_get_cached(image)
        if cached_file.present?
          cached_file
        else
          file_to_cache = yield
          process_cache(file_to_cache, image)

          file_to_cache
        end

      else
        yield
      end
  end

  def try_get_cached(image)
    FileUtils.mkdir_p("#{DIR_PATH}/#{image.id}")
    cached_file_path = build_cached_file_path(image)

    if File.exists?(cached_file_path)
      MiniMagick::Image.open(cached_file_path)
    else
      nil
    end
  end

  def process_cache(file, image)
    FileUtils.mkdir_p("#{DIR_PATH}/#{image.id}")
    cached_file_path = build_cached_file_path(image)
    file.write(cached_file_path)

    true
  end

  def resize(mm_file)
    case @params[:type]
      when 'to_fit'
        resize_to_fit(mm_file)
      when 'to_fill'
        resize_to_fill(mm_file)
      else
        resize_to_fit(mm_file)
    end
  end

  def build_cached_file_path(image)
    filename_parts = %i{width height type gravity}.map {|key| @params[key] }

    "#{DIR_PATH}/#{image.id}/#{filename_parts.join('_')}.#{image.image.file.extension}"
  end

  def resize_to_fit(mm_file)
    mm_file.combine_options do |cmd|
      cmd.resize "#{@params[:width]}x#{@params[:height]}"
    end

    mm_file
  end

  def resize_to_fill(mm_file)
    width, height, gravity = @params[:width], @params[:height], @params[:gravity]
    cols, rows = mm_file[:dimensions]

    mm_file.combine_options do |cmd|
      if width != cols || height != rows
        scale_x = width/cols.to_f
        scale_y = height/rows.to_f
        if scale_x >= scale_y
          cols = (scale_x * (cols + 0.5)).round
          rows = (scale_x * (rows + 0.5)).round
          cmd.resize "#{cols}"
        else
          cols = (scale_y * (cols + 0.5)).round
          rows = (scale_y * (rows + 0.5)).round
          cmd.resize "x#{rows}"
        end
      end
      cmd.gravity gravity
      cmd.background "rgba(255,255,255,0.0)"
      cmd.extent "#{width}x#{height}" if cols != width || rows != height
    end

    mm_file
  end

  def normalize_params(params)
    {
        width: params.fetch(:width, 640).to_i,
        height: params.fetch(:height, params.fetch(:width, 640)).to_i,
        type: params.fetch(:type, 'to_fit'),
        gravity: params.fetch(:gravity, 'center'),
        category: params[:category]
    }
  end
end