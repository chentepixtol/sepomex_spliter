class Worker

    def initialize(dumper, service_encryption, args)
        @dumper = dumper
        @service_encryption = service_encryption
        @args = args
    end

    def subscribe(listener)
        listener.message do |channel, msg|
            decrypted_message = @service_encryption.decrypt(msg)
            row = JSON.parse(decrypted_message)
            next if !accept(row)
            process(row)
        end
    end

    def accept(row)
        return true
    end

    def process(row)
        @dumper.dump(row)
    end

end
