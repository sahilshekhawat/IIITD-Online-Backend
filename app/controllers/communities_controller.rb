class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @communities = Community.all
    respond_with(@communities)
  end

  def show
    @user = current_user
    respond_with(@community)
  end

  def new
    @community = Community.new
    respond_with(@community)
  end

  def deactivate
  end

  def followers
    @followers = @community.community_followers.paginate(page: params[:page])
  end

  def edit

  end

  def create
    @community = Community.new(community_params)
    @community.slug = @community.name.downcase.tr(" ", "-")
    @community.user_id = current_user.id
    @community.save
    respond_with(@community)
  end

  def update
    if @community.update(community_params)
      @community.slug = @community.name.downcase.tr(" ", "-")
      @community.save
      redirect_to community_path(@community)
    else
      render :edit
    end
  end

  def destroy
    @community.destroy
    respond_with(@community)
  end

  def all
    @user = User.find(params[:id])
    @communities = Community.where(:user_id => @user.id)
  end

  private
    def set_community
      @community = Community.find(params[:id])
    end

    def community_params
      params.require(:community).permit(:name, :about, :avatar, :cover)
    end
end
