#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
end

class Order  < ActiveRecord::Base
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	erb :about
end

get '/products' do
	@products = Product.order('created_at DESC')
	erb :products
end



post '/cart' do
	 @orders_input = params[:orders]
	 @items = parse_orders_input @orders_input

	 if @items.length == 0
	 	return erb :cart_is_empty
	 end
	 @items.each do |item|
	 	item[0] = Product.find(item[0])
	 end
	erb :cart
end

get '/place_order' do
 	@c = Order.new 
 	@ord = Order.all
	erb :place_order
end

post '/place_order' do
	 @c = Order.new params[:order]
	if @c.save
		erb :order_placed

	else
		@error = @c.errors.full_messages.first
		 
	end 
	 
end

get '/admin' do
	@orders = Order.order('created_at DESC')
	erb :admin
end


def parse_orders_input orders_input
	s1 = orders_input.split(/,/)
	arr = []

	s1.each do |x|
		s2 = x.split(/\=/)
		s3 = s2[0].split(/_/)

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]
		arr.push arr2
	end	
	return arr
end


