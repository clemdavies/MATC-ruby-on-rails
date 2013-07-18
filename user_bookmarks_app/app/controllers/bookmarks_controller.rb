class BookmarksController < ApplicationController


  before_filter :signed_in_user, only: [:index]
  before_filter :correct_user,   only: [:edit,:update,:destroy]

  # GET /bookmarks
  def index
    @bookmarks = current_user.bookmarks.all
  end#index

  # GET /bookmarks/1
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end#new

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  # POST /bookmarks
  def create
    @bookmark = current_user.bookmarks.build(params[:bookmark])

      if @bookmark.save
        redirect_to @bookmark, notice: 'Bookmark was successfully created.'
      else
        render action: "new"
      end
  end#create

  # PUT /bookmarks/1
  def update
    @bookmark = current_user.bookmarks.find(params[:id])

      if @bookmark.update_attributes(params[:bookmark])
        redirect_to @bookmark, notice: 'Bookmark was successfully updated.'
      else
        render action: "edit"
      end
  end#update

  # DELETE /bookmarks/1
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_url
  end#destroy


  private

    def correct_user
      @micropost = current_user.bookmarks.find(params[:id])
    rescue
      redirect_to root_url
    end

    def signed_in_user
       unless signed_in?
         store_location
         redirect_to signin_url, notice: "Please sign in."
       end
    end


end
