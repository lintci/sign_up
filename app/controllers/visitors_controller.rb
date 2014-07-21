class VisitorsController < ApplicationController
  before_filter :authenticate_user!, only: :index
  after_action :verify_authorized, only: :index

  def index
    @visitors = Visitor.all
    authorize Visitor
  end

  def show
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.where(visitor_params).first_or_initialize

    if @visitor.save
      redirect_to root_path, notice: "You've been added! We'll let you know when it's ready!"
    else
      render :show
    end
  end

private

  def visitor_params
    params.require(:visitor).permit(:email)
  end
end
