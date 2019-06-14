class CreateBooksReader < ActiveRecord::Migration[5.2]
  def change
    create_join_table :readers, :books

  end
end
