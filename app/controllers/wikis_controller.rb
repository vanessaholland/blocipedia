class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collabs = Collaborator.where(wiki_id: @wiki.id)
    collaborator_list = []
    @collabs.each do |collab|
      iduser = collab.user_id
      collaboration_user = User.where(id: iduser).first
      collaborator_list.push(collaboration_user)
    end
    @collaborations = collaborator_list
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    if @wiki.save
      unless params[:wiki][:collaborations] == ""
        user_list = params[:wiki][:collaborations]
        user_list.split(",").each do |email|
          user = User.where(email: email).first
          @my_collab = collaboration(user, @wiki)
        end
      end
      flash[:notice] = 'Wiki was saved.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]


    if @wiki.save
      unless params[:wiki][:collaborations] == ""
        user_list = params[:wiki][:collaborations]
        user_list.split(",").each do |email|
          user = User.where(email: email).first
          @my_collab = collaboration(user, @wiki)
        end
      end
      flash[:notice] = 'Wiki was updated.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end
end
