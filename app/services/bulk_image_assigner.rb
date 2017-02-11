class BulkImageAssigner
  def self.process(params)
    image_ids = params[:images][:ids].split(',')
    tag_ids = params[:images][:tag_id].split(',')
    tags = Tag.find(tag_ids)
    Image.find(image_ids).each do |i|
      tags.each do |t|
        Tagging.find_or_create_by(image: i, tag: t)
      end
    end

    true
  rescue StandardError => e
    Rails.logger.warn("#{e} #{e.message}. #{e.backtrace.to_a.first(10)}")
    false
  end
end