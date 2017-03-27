class FileDumper

  def initialize(name)
    @filename = "data/" + name.gsub(/\s/, '_') + ".txt"
    File.new(@filename, "w") if !File.exist?(@filename)
  end

  def dump(row)
    File.open(@filename, "a") do |file|
      file.puts row.values.join("|")
    end
  end

end