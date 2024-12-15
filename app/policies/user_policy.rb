class UserPolicy < BasePolicy
  def edit
    record.owner?
  end

  def update
    record.owner?
  end
end
