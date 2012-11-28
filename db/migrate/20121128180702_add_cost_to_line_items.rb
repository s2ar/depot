class AddCostToLineItems < ActiveRecord::Migration

  def change
  	add_column :line_items, :cost, :decimal, precision: 8, scale: 2
  	
  	LineItem.all.each do |item|  	
  		product = Product.find_by_id(item.product_id)
  		item.update_attribute(:cost, product.price*item.quantity)
  	end  	
  end
end
