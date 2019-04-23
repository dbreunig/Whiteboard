Sequel.migration do
    change do
        create_table(:things) do
            primary_key :id
            String :title, null: false
            String :note
            String :category
            Date :created_at, null: false
            DateTime :due_on
            DateTime :completed_at
            Boolean :completed, default: false

            index :created_at
            index :due_on
            index :category
        end
    end
  end