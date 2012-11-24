class CreateBookSearchHistories < ActiveRecord::Migration
  def change
    create_table :book_search_histories do |t|
      t.string :book_name
      t.decimal :search_count

      t.timestamps
    end
  end
end
