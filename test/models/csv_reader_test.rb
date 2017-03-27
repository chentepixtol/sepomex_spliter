require 'test_helper'

class CsvReaderTest < ActiveSupport::TestCase

    test "csv reader should parse file" do
        csv_reader = CsvReader.new("test/fixtures/files/CPdescarga.txt")
        csv_reader.read { |row|
            assert row.key?("d_codigo")
            assert row.key?("d_asenta")
            assert row.key?("d_tipo_asenta")
            assert row.key?("D_mnpio")
            assert row.key?("d_estado")
            assert row.key?("d_ciudad")
            assert row.key?("d_CP")
            assert row.key?("c_estado")
            assert row.key?("c_oficina")
            assert row.key?("c_CP")
            assert row.key?("c_tipo_asenta")
            assert row.key?("c_mnpio")
            assert row.key?("id_asenta_cpcons")
            assert row.key?("d_zona")
            assert row.key?("c_cve_ciudad")
        }
    end

end
