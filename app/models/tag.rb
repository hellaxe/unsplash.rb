class Tag < ApplicationRecord

  has_many :taggings, dependent: :destroy
  has_many :images, through: :taggings
  def self.find_by_name(name)
    where('name = :name OR :name = ANY(aliases)', name: name)
  end

  def self.ilike(name)
    sql = "SELECT DISTINCT tags.*, alias "\
          "FROM tags "\
          "LEFT JOIN LATERAL unnest(tags.aliases) alias ON true "\
          "WHERE name ILIKE '%#{name}%' OR alias ILIKE '%#{name}%'"

    Tag.find_by_sql(sql).uniq
  end

  def virtual_aliases
    self.aliases.join(', ')
  end

  def virtual_aliases=(value)
    self.aliases = value.split(',').map(&:strip)
  end

end
