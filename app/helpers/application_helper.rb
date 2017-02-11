module ApplicationHelper

  def human_size(size)
    size.to_s(:human_size)
  end
end
