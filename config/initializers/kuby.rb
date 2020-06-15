require 'kuby'
require 'aws-sdk-eks'

class LocalGems
  def apply_to(dockerfile)
    dockerfile.copy('./lib/kuby-core/kuby-core.gemspec', './lib/kuby-core/kuby.gemspec')
    dockerfile.copy('./lib/kuby-core/lib/kuby/version.rb', './lib/kuby-core/lib/kuby/version.rb')

    # dockerfile.copy('./lib/kuby-azure/kuby-azure.gemspec', './lib/kuby-azure/kuby-azure.gemspec')
    # dockerfile.copy('./lib/kuby-azure/lib/kuby/azure/version.rb', './lib/kuby-azure/lib/kuby/azure/version.rb')

    # dockerfile.copy('./lib/kuby-digitalocean/kuby-digitalocean.gemspec', './lib/kuby-digitalocean/kuby-digitalocean.gemspec')
    # dockerfile.copy('./lib/kuby-digitalocean/lib/kuby/digitalocean/version.rb', './lib/kuby-digitalocean/lib/kuby/digitalocean/version.rb')

    # dockerfile.copy('./lib/kuby-linode/kuby-linode.gemspec', './lib/kuby-linode/kuby-linode.gemspec')
    # dockerfile.copy('./lib/kuby-linode/lib/kuby/linode/version.rb', './lib/kuby-linode/lib/kuby/linode/version.rb')

    dockerfile.copy('./lib/kube-dsl/kube-dsl.gemspec', './lib/kube-dsl/kube-dsl.gemspec')
    dockerfile.copy('./lib/kube-dsl/lib/kube-dsl/version.rb', './lib/kube-dsl/lib/kube-dsl/version.rb')

    # dockerfile.copy('./lib/kuby-cert-manager/kuby-cert-manager.gemspec', './lib/kuby-cert-manager/kuby-cert-manager.gemspec')
    # dockerfile.copy('./lib/kuby-cert-manager/lib/kuby/cert-manager/version.rb', './lib/kuby-cert-manager/lib/kuby/cert-manager/version.rb')

    # dockerfile.copy('./lib/kuby-kube-db/kuby-kube-db.gemspec', './lib/kuby-kube-db/kuby-kube-db.gemspec')
    # dockerfile.copy('./lib/kuby-kube-db/lib/kuby/kube-db/version.rb', './lib/kuby-kube-db/lib/kuby/kube-db/version.rb')

    # dockerfile.copy('./lib/docker-remote/docker-remote.gemspec', './lib/docker-remote/docker-remote.gemspec')
    # dockerfile.copy('./lib/docker-remote/lib/docker/remote/version.rb', './lib/docker-remote/lib/docker/remote/version.rb')

    # dockerfile.copy('./lib/helm-rb/helm-rb.gemspec', './lib/helm-rb/helm-rb.gemspec')
    # dockerfile.copy('./lib/helm-rb/lib/helm-rb/version.rb', './lib/helm-rb/lib/helm-rb/version.rb')

    # dockerfile.copy('./lib/helm-cli/helm-cli.gemspec', './lib/helm-cli/helm-cli.gemspec')
    # dockerfile.copy('./lib/helm-cli/lib/helm-cli/version.rb', './lib/helm-cli/lib/helm-cli/version.rb')

    # dockerfile.copy('./lib/kubernetes-cli/kubernetes-cli.gemspec', './lib/kubernetes-cli/kubernetes-cli.gemspec')
    # dockerfile.copy('./lib/kubernetes-cli/lib/kubernetes-cli/version.rb', './lib/kubernetes-cli/lib/kubernetes-cli/version.rb')

    dockerfile.copy('./lib/kuby-sidekiq/kuby-sidekiq.gemspec', './lib/kuby-sidekiq/kuby-sidekiq.gemspec')
    dockerfile.copy('./lib/kuby-sidekiq/lib/kuby/sidekiq/version.rb', './lib/kuby-sidekiq/lib/kuby/sidekiq/version.rb')
  end
end

Kuby.define(:production) do
  docker do
    credentials do
      username Rails.application.credentials[:KUBYAPP_DOCKER_USERNAME]
      password Rails.application.credentials[:KUBYAPP_DOCKER_PASSWORD]
      email Rails.application.credentials[:KUBYAPP_DOCKER_EMAIL]
    end

    distro :alpine
    image_url 'registry.gitlab.com/camertron/kuby-app'
    insert :local_gems, LocalGems.new, before: :bundler_phase
  end

  kubernetes do
    add_plugin :rails_app do
      hostname 'getkuby.io'
      tls_enabled false
    end

    add_plugin :sidekiq

    provider :digitalocean do
      access_token Rails.application.credentials[:KUBYAPP_DIGITALOCEAN_ACCESS_TOKEN]
      cluster_id '1144432a-6a4d-4c86-bfb0-5d931c63bdc1'
    end

    # provider :minikube

    # provider :azure do
    #   tenant_id '398b9b83-6ea6-47df-b629-8cae96852653'
    #   client_id 'fba52f86-e892-49ff-b2ef-88677d784977'
    #   client_secret 'F7~.by-.T-np.5W6ffMs3rQqou0xiDJws5'
    #   subscription_id 'c035e0dd-a061-4d70-a178-3b59554c923c'
    #   resource_group_name 'kuby'
    #   resource_name 'kubyapp'
    # end

    # provider :eks do
    #   region 'us-west-2'
    #   cluster_name 'kubyapp'
    #   credentials(
    #     Aws::Credentials.new(
    #       ENV['KUBYAPP_AWS_ACCESS_KEY_ID'],
    #       ENV['KUBYAPP_AWS_ACCESS_SECRET_KEY']
    #     )
    #   )
    # end
  end
end
