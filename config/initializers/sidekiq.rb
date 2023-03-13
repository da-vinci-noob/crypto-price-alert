Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.config_for(:redis).jobs_url }
  config.on(:startup) do
    already_scheduled = Sidekiq::ScheduledSet.new.any? {|job| job.klass == 'ProcessAlertJob' }
    ProcessAlertJob.perform_async unless already_scheduled
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.config_for(:redis).jobs_url }
end
