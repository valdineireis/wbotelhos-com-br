class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.boolean     :author,  null: false, default: false
      t.string      :email,   null: false
      t.string      :name,    null: false
      t.text        :body,    null: false
      t.string      :url

      t.references  :article, null: false
      t.references :comment

      t.timestamps
    end

    add_index :comments, :article_id
  end

  def down
    drop_table :comments
  end
end
