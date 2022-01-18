# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :login
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
