class HomeController < ApplicationController

  before_action :authenticate_account!
  before_action :validate_date, only: [:search]

  def index; end

  def search
    first_date = set_params[:first_date].to_date
    second_date = set_params[:second_date].to_date
    sbif_data = SettingSbif.between(first_date, second_date)
    @dolar_data = SettingSbif.chart_data(sbif_data, 'dolar')
    @uf_data = SettingSbif.chart_data(sbif_data)
    @currency = Utils::Calculator::Currency.new(sbif_data).result
  end

  private

  def set_params
    params.require(:range).permit(:first_date, :second_date)
  end

  def validate_date
    first_date = set_params[:first_date].to_date
    second_date = set_params[:second_date].to_date
    if first_date.present? && second_date.present?
      if second_date > first_date
        flash[:notice] = "Busqueda entre los periodos #{set_params[:first_date]} al #{set_params[:second_date]}."
      else
        flash[:alert] = 'Primer periodo no puede ser mayor que el segundo!. Vuelva a Buscar'
        redirect_to root_path
      end
    else
      flash[:alert] = 'Ingresar ambos periodos'
      redirect_to root_path
    end
  end
end
