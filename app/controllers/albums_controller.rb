class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @q = Album.ransack(params[:q])
    @albums = @q.result      
  end
  
  def my_albums
    @albums = current_user.albums
  end 
  
  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new    
  end
  
  def create
    @album = current_user.albums.create(album_params)
    
    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end    
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to fallback_location: root_path, notice: "successfully deleted"
  end

  def destroyAllImages
    @album = Album.find(params[:id])
    @album.images.purge
    redirect_to fallback_location: root_path, notice: "successfully deleted"
  end

  def purge 
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to fallback_location: album_path, notice: "successfully deleted"
  end  

  private
  def album_params
    params.require(:album).permit(:title, :description, :foreign_key, :all_tags, images: [])
  end
end
