class OrderLinesController < ApplicationController

  before_filter :find_order
  before_filter :find_order_line, :except => [:create]

  def create
    @order_line = OrderLine.new(params[:order_line])
    @order_line.order = @order
    if @order_line.save
      @order_line = OrderLine.new
    end
    render :partial => 'order_lines'
  end

  def update
    @order_line = @order.order_lines.find(params[:id])
    @order_line.update_attributes(params[:order_line])
    
    @order = find_order
    render :partial => 'order_lines', :collection => @order.order_lines, :as => :order_line, :locals => {:order => @order}
  end

  def destroy
    @order_line.destroy
    @order_line = OrderLine.new
    render :partial => 'order_lines'
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_order_line
    @order_line = OrderLine.find(params[:id])
  end
end
