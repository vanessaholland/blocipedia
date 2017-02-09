class AddUserToCollaborators < ActiveRecord::Migration[5.0]
  def change
    add_reference :collaborators, :user, foreign_key: true
  end
end
