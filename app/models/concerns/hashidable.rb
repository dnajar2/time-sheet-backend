module Hashidable
  extend ActiveSupport::Concern

  included do
    def hashid
      HASHIDS.encode(id)
    end

    # Useful for controllers
    def self.find_by_hashid!(hash)
      decoded = HASHIDS.decode(hash).first
      raise ActiveRecord::RecordNotFound unless decoded
      find(decoded)
    end
  end
end
