class CreateOrders < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.string :name
  		t.string :phone
  		t.text :address
  		t.text :order
  		
  		t.timestamps
  	end
  end
end
