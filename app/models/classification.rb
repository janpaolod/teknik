class Classification
  include Mongoid::Document
  field :name,      :type => String
  field :permalink, :type => String
  
  references_many :promos #try promos to make merchants classification as reference
  references_and_referenced_in_many :merchants, :inverse_of => :classifications
  
  validates :name,
    :presence => true,
    :uniqueness => true

  before_save :create_permalink

  private

    def create_permalink
      self.permalink = self.name.parameterize
    end
end
