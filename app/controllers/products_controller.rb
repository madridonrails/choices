class ProductsController < ApplicationController

  before_filter :find_product, :except => [:index, :new, :create]

  def index
    @products = Product.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    if @products.empty?
      flash[:notice] = t 'products.no_products'
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if  @product.save
      flash[:success] = t'products.create.success'
      redirect_to products_url
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    if @product.update_attributes(params[:product])
      flash[:success] = t 'products.update.success'
      redirect_to products_url
    else
      render :action => :edit
    end
  end

  def show

  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
