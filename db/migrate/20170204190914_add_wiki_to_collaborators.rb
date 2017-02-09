class AddWikiToCollaborators < ActiveRecord::Migration[5.0]
  def change
    add_reference :collaborators, :wiki, foreign_key: true
  end
end
