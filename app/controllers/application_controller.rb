class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def collaboration(user, wiki)
    @collaborator = Collaborator.new
    @collaborator.user = user
    @collaborator.wiki = wiki

    if @collaborator.save
      flash[:notice] = "Collaborations were successfully added."
    else
      flash[:notice] = "An error has occured, please try again later."
    end
  end
end
