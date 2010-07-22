namespace :application do
  namespace :products do
    desc 'Initialize products'
    task :init => :environment do
      init_products
    end
  end

  namespace :dev do
    desc 'Initialize developing models'
    task :init => :environment do
      init_dev_models
    end
  end
  
private

  def init_products
    descriptions = ['Etiquetas termoadhesivas para la ropa',
      'Tarjetas personales',
      'Invitaciones de cumple',
      'Pegatinas para marcar libros',
      'Tarjetas de Navidad'
    ]

    descriptions.each do |description|
      product = Product.find_or_initialize_by_description(description)
      product.cost_price = 10
      product.wholesale_price = 15
      if product.save
        puts "product #{product.description} created / found"
      else
        puts "Errors while creating #{description}"
      end
    end
  end

  def init_dev_models
    init_dev_clients
    init_products
    init_client_product_customizations
  end

  def init_dev_clients
    puts "\nCreating clients"
    c = Client.find_or_initialize_by_id(1)
    c.address ='Alcalá 1'
    c.town = 'Vicálvaro'
    c.city = 'Madrid'
    c.cif = 'cif-1'
    c.postal_code = 28001
    c.name = 'Fulano de Tal'
    if c.save
      puts "client #{c.name} created"
    else
      puts "Errors while creating client #{c.name}:\n\t#{c.errors.full_messages.join("\n\t")}"
    end

    c = Client.find_or_initialize_by_id(2)
    c.address ='Alcalá 232'
    c.town = 'Las Rozas'
    c.city = 'Madrid'
    c.cif = 'cif-2'
    c.name = 'Mengano 2'
    #c.postal_code = 28002
    if c.save
      puts "client #{c.name} created"
    else
      puts "Errors while creating client #{c.name}:\n\t#{c.errors.full_messages.join("\n\t")}"
    end
  end

  def init_client_product_customizations

    cpc = ClientProductCustomization.find_or_initialize_by_product_id(1)
    cpc.client_id = 1
    cpc.wholesale_price = 1234
    cpc.code = 'custom code'

    if cpc.save
      puts 'added customization'
    else
      puts "Errors while creating customization:\n\t#{c.errors.full_messages.join("\n\t")}"
    end
  end

end


