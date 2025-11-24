HASHIDS = Hashids.new(
  Rails.application.credentials.hashids_salt || ENV["HASHIDS_SALT"],
  Rails.application.credentials.hashids_min_length || ENV["HASHIDS_MIN_LENGTH"].to_i
)
