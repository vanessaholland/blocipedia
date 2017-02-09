class CollaboratorsController < ApplicationController
  def create
  #  @collaborator = Collaborator.new
  @collaboration.user = params[:user]
  @collaboration.wiki = params[:wiki]

     if @collaboration.save
       flash[:notice] = "Collaborations were successfully added."
       redirect_to @wiki
     else
       flash[:notice] = "An error has occured, please try again later."
       redirect_to @wiki
     end
 end

 def destroy
   @wiki = Wiki.find(params[:my_params][:wiki_id])
     @collaboration = Collaborator.find_by(user_id: params[:my_params][:user_id], wiki_id: params[:my_params][:wiki_id])

     if @collaboration.destroy
       flash[:notice] = "Collaboration was removed successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the topic."
       redirect_to @wiki
     end
   end

end
