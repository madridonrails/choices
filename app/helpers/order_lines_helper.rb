module OrderLinesHelper

    def options_for_select_product_for_order_line(order, order_line)
      if order_line.new_record?
        products = Product.all - order.order_lines.collect {|ol| ol.product }
      else
        products = Product.all - (order.order_lines.collect {|ol| ol.product } - [order_line.product])
      end
      products.collect{|p| [p.description, p.id]}.sort
    end
end
