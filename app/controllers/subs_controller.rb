class SubsController < ApplicationController
  before_action :require_signed_in

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
  end

  def edit
  end

end
