class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :destroy, :follower, :following]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page], per_page: 5)
  end

  def destroy
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		# login_user @user
  		flash[:success] = "Welcome to sample app"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def followers
    @title = "Followers"
    @user = User.find params[:id]
    @users = @user.followers.paginate page: params[:page], per_page: 10
    @users_icon = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  def following
    @title = "Following"
    @user = User.find params[:id]
    @users = @user.following.paginate page: params[:page], per_page: 10
    @users_icon = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
