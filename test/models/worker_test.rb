require 'test_helper'

class WorkerTest < ActiveSupport::TestCase
    test "Worker should be iterate over messages" do

        redis_stub = RedisStub.new()
        dumper = DumperAssert.new(self)

        service_encryption = Encryption.new(
            "config/certificates/private.pem",
            "config/certificates/public.pem",
            "chentux"
        )
        Args = Struct.new(:state)
        worker_state = WorkerState.new(dumper, service_encryption, Args.new('State1'))
        worker_state.subscribe(redis_stub)

        messageToSend = '{"d_codigo":"01120","d_asenta":"Sears Roebuck","d_tipo_asenta":"Unidad habitacional","D_mnpio":"Álvaro Obregón","d_estado":"State1","d_ciudad":"State1","d_CP":"01131","c_estado":"09","c_oficina":"01131","c_CP":"","c_tipo_asenta":"31","c_mnpio":"010","id_asenta_cpcons":"0050","d_zona":"Urbano","c_cve_ciudad":"01"}'
        redis_stub.publish("channel-test", service_encryption.encrypt(messageToSend))
    end

end

class DumperAssert

    def initialize(test_case)
        @test_case = test_case
    end

    def dump(row)
        @test_case.assert_equal("01120", row["d_codigo"])
        @test_case.assert_equal("Sears Roebuck", row["d_asenta"])
        @test_case.assert_equal("Unidad habitacional", row["d_tipo_asenta"])
        @test_case.assert_equal("Álvaro Obregón", row["D_mnpio"])
        @test_case.assert_equal("State1", row["d_estado"])
        @test_case.assert_equal("State1", row["d_ciudad"])
    end

end


class RedisStub

    def message(&block)
      @callback= block
    end

    def publish(channel, message)
        @callback.call(channel, message)
    end
end
