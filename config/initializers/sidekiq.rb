if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: Kuby.definition.kubernetes.plugin(:sidekiq).url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: Kuby.definition.kubernetes.plugin(:sidekiq).url }
  end
end
