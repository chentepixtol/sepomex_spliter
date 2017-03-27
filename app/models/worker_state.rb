class WorkerState < Worker

  def accept(row)
    return row["d_estado"] == @args.state
  end

end
