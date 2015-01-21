Rails.logger = Le.new(ENV['LOGENTRIES_TOKEN']) if Rails.env.production?
