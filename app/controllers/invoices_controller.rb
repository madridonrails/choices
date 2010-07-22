class InvoicesController < ApplicationController

  before_filter :find_order, :only => [:new, :create]
  before_filter :find_invoice, :except => [:new, :create, :index]

  def index

    @filter = params[:filter]
    conditions = [' 1 = 1 ']

    unless @filter.blank?
      unless @filter[:code].blank?
        conditions[0] << ' AND invoices.code LIKE ? '
        conditions << "%#{@filter[:code]}%"
      end
      conditions[0] << set_date_conditions(@filter)
      conditions[0] << " AND invoices.paid = #{@filter[:paid]}" unless @filter[:paid].blank?
      conditions[0] << " AND invoices.incidences <> '' " unless @filter[:incidences].blank?
    end

    @invoices= Invoice.paginate(
      :conditions => conditions,
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    flash[:notice] = t'invoices.no_invoices' if @invoices.empty?

  end

  def new
    @invoice = @order.build_invoice
    @invoice.code = INVOICE_PREFIX + @order.internal_code.sub(ORDER_PREFIX, '').sub(ORDER_SUFFIX, '') + "#{eval(INVOICE_SUFFIX)}"
    @invoice.date = Date.today.strftime(DATE_FORMAT)
  end

  def create
    @invoice = @order.build_invoice(params[:invoice])
    if @invoice.save
      flash[:success] = t'invoices.create.success'
      redirect_to orders_path
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @invoice.update_attributes(params[:invoice])
      flash[:success] = t'invoices.update.success'
      redirect_to orders_path
    else
      render :edit
    end
  end

  def print
    render :layout => 'print'
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path
  end

  def show

  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end

end
