require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Blog
  class Application < Rails::Application
    config.action_mailer.default_url_options  = { host: 'wbotelhos.com.br' }
    config.action_view.field_error_proc       = -> tag, _ { tag }
    config.active_record.whitelist_attributes = true
    config.assets.enabled                     = false
    config.encoding                           = 'utf-8'
    config.filter_parameters                  += [:password]
    config.i18n.default_locale                = :'pt-BR'
    config.i18n.load_path                     += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
    config.time_zone                          = 'Brasilia'
  end
end
