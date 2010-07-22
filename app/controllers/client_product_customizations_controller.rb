class ClientProductCustomizationsController < ApplicationController

  before_filter :find_client, :only => [:create, :index, :destroy, :update]
  before_filter :find_product, :only => [:create, :index, :destroy, :update]
  before_filter :create_new_client_product_customization, :except => [:create, :update]
  before_filter :find_client_product_customization, :except => [:index, :create]
  def index

  end

  def create
    @client_product_customization = ClientProductCustomization.new(params[:client_product_customization])

    unless @client.nil?
      @client_product_customization.client = @client
      if @client_product_customization.save
        @client_product_customization = ClientProductCustomization.new
      end
      render :partial => '/client_product_customizations/client/client_product_customizations' if not @client.blank?
    end

    unless @product.nil?
      @client_product_customization.product = @product
      if @client_product_customization.save
        @client_product_customization = ClientProductCustomization.new
      end
      render :partial => '/client_product_customizations/product/client_product_customizations' if not @product.blank?
    end

  end

  def update
    if @client_product_customization.update_attributes(params[:client_product_customization])
      @client_product_customization = ClientProductCustomization.new
    end
    render :partial => '/client_product_customizations/client/client_product_customizations' if not @client.blank?
    render :partial => '/client_product_customizations/product/client_product_customizations' if not @product.blank?
  end

  def destroy
    @client_product_customization.destroy
    @client_product_customization = ClientProductCustomization.new
    render :partial => '/client_product_customizations/client/client_product_customizations' if not @client.blank?
    render :partial => '/client_product_customizations/product/client_product_customizations' if not @product.blank?
  end
  
  private

  def find_client
    @client = Client.find(params[:client_id]) rescue nil
  end

  def find_product
    @product = Product.find(params[:product_id]) rescue nil
  end

  def create_new_client_product_customization
    @client_product_customization = ClientProductCustomization.new
  end

  def find_client_product_customization
    @client_product_customization = ClientProductCustomization.find(params[:id])
  end
end
