# frozen_string_literal: true

class ClientsController < ApplicationController
  include Filterable

  before_action :set_client, only: %i[edit destroy update]
  before_action :set_clients, only: %i[index filtered_list]

  def index; end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      respond_to do |format|
        format.html { redirect_to clients_path, notice: 'Client was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Client was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      respond_to do |format|
        format.html { redirect_to clients_path, notice: 'client was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Client was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_path, notice: 'client was Deleted successfully' }
      format.turbo_stream { flash.now[:notice] = 'Client was successfully destroyed.' }
    end
  end

  def filtered_list
    render turbo_stream: [
      turbo_stream.replace('clients', partial: 'clients'),
      turbo_stream.update('counter', @clients.size),
      turbo_stream.update('clients_pagination', partial: 'client/pagination')
    ]
  end

  private

  def set_clients
    @pagy, @clients = pagy(filter!(Client))
  end

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:id, :first_name, :last_name, :email, :stage, :phone_number, :company_id,
                                   :probability)
  end
end
