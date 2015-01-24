if Rails.env.production?
  logger = Le.new(Rails.application.secrets.logentries_token)
  logger.formatter = proc do |_, _, _, message|
    message
  end

  Rails.application.config.lograge.logger = logger
end
