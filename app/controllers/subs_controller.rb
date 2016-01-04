class SubsController < ApplicationController
  before_action :require_signed_in
  before_action :is_moderator?, only: [:edit, :update]

  helper_method :is_moderator?

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
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def current_sub
    Sub.find(params[:id])
  end

  def is_moderator?
    if current_sub
      current_sub.moderator == current_user
    else
      false
    end
  end

  def ensure_moderator
    unless is_moderator?
      redirect_to sub_url(current_sub)
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
