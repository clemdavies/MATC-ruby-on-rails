class UsersController < ApplicationController

  before_filter :correct_user,   only: [:show,:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the User Bookmarks App!"
      redirect_to @user
    else
      render 'new'
    end
  end #create

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end#update


  private
    def correct_user
       unless signed_in?
         store_location
         redirect_to signin_url, notice: "Please sign in."
       else
         @user = User.find(params[:id])
         redirect_to(root_path) unless current_user?(@user)
      end
    end
  #private

end
