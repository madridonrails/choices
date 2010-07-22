module ClientProductCustomizationsHelper

  def options_for_select_product(client, client_product_customization)
    if client_product_customization.new_record?
      products = Product.all - client.customized_products
    else
      products = Product.all - (client.customized_products - [client_product_customization.product])
    end
    products.collect{|p| [p.description, p.id]}.sort
  end

  def options_for_select_client(product, client_product_customization)
    if client_product_customization.new_record?
      clients = Client.all - product.customized_clients
    else
      clients = Client.all - (product.customized_clients - [client_product_customization.client])
    end
    clients.collect{|c| [c.name, c.id]}.sort
  end
end
