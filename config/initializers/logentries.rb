if Rails.env.production?
  Rails.logger = Le.new(Rails.application.secrets.logentries_token)
end
