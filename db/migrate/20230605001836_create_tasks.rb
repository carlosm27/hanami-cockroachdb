# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :tasks do
      primary_key :id
      column :task, :text, null: false
      column :completed, :text, null: false
    end  
  end
end
