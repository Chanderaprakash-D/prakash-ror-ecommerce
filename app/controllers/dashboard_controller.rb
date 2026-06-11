class DashboardController < ApplicationController
  def index
    @total_products = Product.count
    @total_categories = Category.count
    @total_customers = Customer.count
    @total_orders = Order.count
    @total_revenue = Order.sum(:total_price)
  end
end