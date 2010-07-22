class OrdersController < ApplicationController

  before_filter :find_order, :except => [:index, :new, :create]
  before_filter :new_order_line, :only => [:edit, :update, :update_order_from_client]

  def index
    @filter = params[:filter]
    conditions = [' 1 = 1 ']

    unless @filter.blank?
      unless @filter[:code].blank?
        conditions[0] << ' AND orders.code LIKE ? '
        conditions << "%#{@filter[:code]}%"
      end
      conditions[0] << " AND orders.client_id = #{@filter[:client_id]}" unless @filter[:client_id].blank?
      conditions[0] << set_date_conditions(@filter)
    end
    @orders = Order.paginate(
      :conditions => conditions,
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    if @orders.empty?
      flash[:notice] = t 'orders.no_orders'
    end
  end

  def new
    @order = Order.new
    @order.date = Date.today.strftime(DATE_FORMAT)
  end

  def create
    @order = Order.new(params[:order])
    if  @order.save
      flash[:success] = t'orders.create.success'
      redirect_to edit_order_url(@order)
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    if @order.update_attributes(params[:order])
      flash[:success] = t 'orders.update.success'
      redirect_to orders_url
    else
      render :action => :edit
    end
  end

  def show

  end

  def destroy
    @order.destroy
    redirect_to orders_url
  end

  def update_order_from_client
    @order = Order.new(params[:order]) if @order.nil?
    client = Client.find(params[:order][:client_id])
    @order.client = client
    @order.address = client.address unless client.address.blank?
    @order.postal_code = client.postal_code unless client.postal_code.blank?
    @order.city = client.city unless client.city.blank?
    @order.town = client.town unless client.town.blank?
    @order.responsible = client.responsible unless client.responsible.blank?
    if @order.new_record?
      @order.order_lines.build
      render :partial => 'new_form'
    else
      render :partial => 'edit_form'
    end
  end

  def cancel
    @order.cancel!
    redirect_to edit_order_path(@order)
  end

  def deliver
    @order.deliver!
    redirect_to edit_order_path(@order)
  end

  def mark_as_pendant
    @order.mark_as_pendant!
    redirect_to edit_order_path(@order)
  end

  def mark_as_with_incidences
    @order.mark_as_with_incidences!
    redirect_to edit_order_path(@order)
  end

  private

  def find_order
    @order = Order.find(params[:id]) rescue nil
  end

  def new_order_line
    @order_line = OrderLine.new
  end

end
