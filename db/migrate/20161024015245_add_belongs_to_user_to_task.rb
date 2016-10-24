class AddBelongsToUserToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.belongs_to :user, index: true
    end
  end
end
