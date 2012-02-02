class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password
      t.boolean :role_one
      t.boolean :role_two
      t.boolean :role_three

      t.timestamps
    end
    
    (1..3).each do |i| 
      User.create(:username => 'user' + i.to_s, :password => Digest::SHA1.hexdigest('password'))  
    end 
  end
end
