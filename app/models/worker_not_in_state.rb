class WorkerNotInState < WorkerState

  def accept(row)
    return !super(row)
  end

end
