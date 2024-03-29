Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = {
  #   metastore: Rails.application.secrets.redis_url,
  #   entitystore: Rails.application.secrets.redis_url
  # }

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = true
  config.static_cache_control = 'public, max-age=2592000'

  config.middleware.insert_before ActionDispatch::Static, Rack::Deflater

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # `config.assets.precompile` has moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :redis_store, Rails.application.secrets.redis_url, {expires_in: 90.minutes, namespace: 'application'}

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 587,
    domain: Rails.application.secrets.domain_name,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: Rails.application.secrets.email_provider_username,
    password: Rails.application.secrets.email_provider_password
  }
  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => Rails.application.secrets.domain_name }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.logger = Le.new(ENV['LOGENTRIES_TOKEN'])
  config.logger.formatter = proc do |severity, timestamp, _, message|
    data = {severity: severity, timestamp: timestamp}

    if message.is_a? Hash
      data.merge!(message)
    else
      data.merge!(message: message)
    end

    JSON.dump(data)
  end

  config.lograge.enabled = true
  config.lograge.logger = config.logger
  config.lograge.formatter = Lograge::Formatters::Raw.new
  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].reject do |key|
      %w(controller action).include?(key)
    end

    {
      'params' => params,
      'timestamp' => Time.now.iso8601,
      'severity' => 'INFO'
    }
  end
end
