class ClientsController < ApplicationController
  
  before_filter :find_client, :except => [:index, :new, :create]

  def index
    @clients = Client.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    if @clients.empty?
      flash[:notice] = t 'clients.no_clients'
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if  @client.save
      flash[:success] = t'clients.create.success'
      redirect_to clients_url
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    if @client.update_attributes(params[:client])
      flash[:success] = t 'clients.update.success'
      redirect_to clients_url
    else
      render :action => :edit
    end
  end

  def show

  end

  def destroy
    @client.destroy
    redirect_to clients_url
  end

  private

  def find_client
    @client = Client.find(params[:id])
  end

end
