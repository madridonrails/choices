ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  map.resources :products, :has_many => :client_product_customizations
  map.resources :clients, :has_many => :client_product_customizations
  map.resources :orders do |order|
    order.resources :order_lines
    order.resource :delivery_note, :only => [:new, :create]
    order.resource :invoice, :only => [:new, :create]
  end
  map.cancel ':controller/:id/cancel', :action => 'cancel'
  map.deliver ':controller/:id/deliver', :action => 'deliver'
  map.mark_as_with_incidences ':controller/:id/mark_as_with_incidences', :action => 'mark_as_with_incidences'
  map.mark_as_pendant ':controller/:id/mark_as_pendant', :action => 'mark_as_pendant'

  map.resources :delivery_notes, :except => [:new, :create]
  map.print ':controller/:id/print', :action => 'print'
  map.resources :invoices, :except => [:new, :create]

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => :products

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
