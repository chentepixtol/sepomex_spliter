require 'json'
require 'openssl'
require 'base64'

namespace :worker do

    desc "This task run workers"
    task :state, [:state]  => :environment do |task, args|

        redis = Redis.new(:timeout => 0)

        service_encryption = Encryption.new(
            Rails.application.secrets.encryption_private_key,
            Rails.application.secrets.encryption_public_key,
            Rails.application.secrets.encryption_password
        )

        worker_state = WorkerState.new(service_encryption, args)
        redis.subscribe('csv-channel') do |listener|
            worker_state.subscribe(listener)
        end
    end

end
