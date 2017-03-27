require 'json'
require 'openssl'
require 'base64'

namespace :worker do

    desc "This task run workers"
    task :state, [:state]  => :environment do |task, args|

        redis = Redis.new(:timeout => 0)
        dumper = FileDumper.new(args.state)
        service_encryption = get_service_encryption()

        worker_state = WorkerState.new(dumper, service_encryption, args)
        redis.subscribe('csv-channel') do |listener|
            worker_state.subscribe(listener)
        end
    end

    task :not_in_state, [:state]  => :environment do |task, args|

        redis = Redis.new(:timeout => 0)
        dumper = FileDumper.new("not_" + args.state)
        service_encryption = get_service_encryption()

        worker_state = WorkerNotInState.new(dumper, service_encryption, args)
        redis.subscribe('csv-channel') do |listener|
            worker_state.subscribe(listener)
        end
    end

    def get_service_encryption()
        return service_encryption = Encryption.new(
            Rails.application.secrets.encryption_private_key,
            Rails.application.secrets.encryption_public_key,
            Rails.application.secrets.encryption_password
        )
    end

end
