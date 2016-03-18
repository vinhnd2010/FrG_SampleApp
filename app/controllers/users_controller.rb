class UsersController < ApplicationController
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

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
