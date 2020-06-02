class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.text :content

      t.timestamps
    end
  end
end
