class CsvReader

  def initialize(file_path)
    @file_path = file_path
  end

  def read (&callback)
    headers = nil
    File.foreach(@file_path).with_index do |line, index|
      line.encode!('UTF-8', 'ISO-8859-1', :invalid => :replace)
      line.strip!
      if index == 1
        headers = line.split('|')
      end
      if index <= 1
        next
      end

      columns = line.split('|')
      object = {}
      headers.each_with_index {|k,i| object[k]=columns[i]}
      callback.call(object)
    end
  end

end
