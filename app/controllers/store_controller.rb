class StoreController < ApplicationController
  def index
  	session[:counter] = (session[:counter].nil?)? 1 : session[:counter] + 1
  	@counter = session[:counter]
  	@products = Product.order(:title)
  	@cart = current_cart
  end

end
