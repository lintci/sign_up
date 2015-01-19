if Rails.env.development?
  Rails.logger = Le.new(ENV['LOGENTRIES_TOKEN'], debug: true)
else
  Rails.logger = Le.new(ENV['LOGENTRIES_TOKEN'])
end
