class VisitorPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @visitor = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    true
  end

  def create?
    true
  end
end
