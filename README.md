# KubyApp

A test Rails app that includes all the Kuby gems as git submodules. Facilitates development of the Kuby gem ecosystem.

## Setup

1. Check out submodules:

    ```bash
    git submodule update --init --recursive
    ```

1. Install required libraries ( macos only):

    ```bash
    brew install mysql
    ```

1. Install dependencies:

    ```bash
    bundle install
    ```

## Running Locally

1. Make sure you have Docker installed. If you're running MacOS or Windows, the easiest way is to download [Docker Desktop](https://www.docker.com/products/docker-desktop).

1. Make sure you have [minikube](https://minikube.sigs.k8s.io/docs/) running. Docker Desktop makes this easy: Preferences -> Kubernetes -> Enable Kubernetes.

1. Set things up:

    ```bash
    bundle exec rake kuby:setup
    ```

1. Build the Docker image locally:

    ```bash
    bundle exec rake kuby:build
    ```

1. Deploy:

    ```bash
    bundle exec rake kuby:deploy
    ```

1. Visit http://localhost:8080 to make sure it's working.

## Running on DigitalOcean

1. Create a Gitlab repo in order use the associated container registry.

1. Create a personal Gitlab access token: [https://gitlab.com/profile/personal_access_tokens](https://gitlab.com/profile/personal_access_tokens).

1. Create a DigitalOcean account and launch a Kubernetes cluster using the dashboard.

1. Create a .env file with the following variables:
    ```
    KUBYAPP_DOCKER_USERNAME="???"
    KUBYAPP_DOCKER_PASSWORD="???"
    KUBYAPP_DOCKER_EMAIL="???"
    KUBYAPP_DIGITALOCEAN_ACCESS_TOKEN="???"
    KUBYAPP_DIGITALOCEAN_CLUSTER_ID="???"
    ```
    The Docker password should be the personal Gitlab access token you created.

1. Build and push the Docker image:

    ```bash
    bundle exec rake kuby:build kuby:push
    ```

1. Change the provider in config/initializers/kuby.rb:

    ```ruby
    provider :digitalocean do
      access_token ENV['KUBYAPP_DIGITALOCEAN_ACCESS_TOKEN']
      cluster_id ENV['KUBYAPP_DIGITALOCEAN_CLUSTER_ID']
    end
    ```

1. Set things up:

    ```bash
    bundle exec rake kuby:setup
    ```

1. Deploy:

    ```bash
    bundle exec rake kuby:deploy
    ```

1. The deploy should automatically create a DigitalOcean load balancer. Find it in the dashboard and visit its IP address. You should see the Rails app running.
