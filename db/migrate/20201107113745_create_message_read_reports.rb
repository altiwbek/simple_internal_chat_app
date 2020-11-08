class CreateMessageReadReports < ActiveRecord::Migration[6.0]
  def change
    create_table :message_read_reports do |t|
      t.references :message, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
