require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Honeycomb
  class Application < Rails::Application

    config.active_job.queue_adapter = :delayed_job

  end
end
