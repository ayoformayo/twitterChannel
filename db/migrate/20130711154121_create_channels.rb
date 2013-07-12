class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |channel|
      channel.integer :user_id
      channel.string :name
      channel.timestamps
    end
  end
end
