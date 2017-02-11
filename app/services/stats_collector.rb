class StatsCollector
  class << self
    def process
      {
          images_size: images_size,
          images_count: Image.count,
          cache_size: cache_size
      }
    end

    protected

    def images_size
      Dir['public/uploads/image/**/*'].inject(0) {|sum, fpath| sum+= File.size(fpath); sum}
    end

    def cache_size
      Dir['public/uploads/cache/**/*'].inject(0) {|sum, fpath| sum+= File.size(fpath); sum}
    end
  end
end