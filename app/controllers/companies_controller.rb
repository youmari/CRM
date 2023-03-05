class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      respond_to do |format|
        format.html { redirect_to clients_path, notice: 'Company was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Company was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
