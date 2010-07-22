class DeliveryNotesController < ApplicationController

  before_filter :find_order, :only => [:new, :create]
  before_filter :find_delivery_note, :except => [:index, :new, :create]

  def index
    @delivery_notes = DeliveryNote.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    flash[:notice] = t'delivery_notes.no_delivery_notes' if @delivery_notes.empty?
  end

  def new
    @delivery_note = @order.build_delivery_note
    @delivery_note.code = DELIVERY_NOTE_PREFIX + @order.internal_code.sub(ORDER_PREFIX, '').sub(ORDER_SUFFIX, '') + "#{eval(DELIVERY_NOTE_SUFFIX)}"
  end

  def create
    @delivery_note = @order.build_delivery_note(params[:delivery_note])
    if @delivery_note.save
      redirect_to orders_path
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @delivery_note.update_attributes(params[:delivery_note])
      redirect_to orders_path
    else
      render :edit
    end
  end

  def destroy
    @delivery_note.destroy
    redirect_to orders_path
  end

  def print
    render :layout => 'print'
  end

  def show
    
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_delivery_note
    @delivery_note = DeliveryNote.find(params[:id])
  end

end
