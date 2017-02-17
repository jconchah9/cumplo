class HomeController < ApplicationController
before_action :authenticate_account!
before_action :validate_date, only: [:search]

  def index
  end

  def search
    date_one = Date.new(set_params['period(1i)'].to_i,set_params['period(2i)'].to_i)
    date_two = Date.new(set_params['period_two(1i)'].to_i,set_params['period_two(2i)'].to_i)
    @sbif_data = SettingSbif.between(date_one,date_two)
    @uf_min = SettingSbif.min_max(@sbif_data, 'minimum', 'uf')
    @uf_max = SettingSbif.min_max(@sbif_data, 'maximum', 'uf')
    @uf_data = SettingSbif.chart_data(@sbif_data, 'uf').compact
    @uf_avg = SettingSbif.avg(@sbif_data, 'uf')
    @dolar_min = SettingSbif.min_max(@sbif_data, 'minimum', 'dolar')
    @dolar_max = SettingSbif.min_max(@sbif_data, 'maximum', 'dolar')
    @dolar_avg = SettingSbif.avg(@sbif_data, 'dolar')
    @dolar_data = SettingSbif.chart_data(@sbif_data,'dolar').compact
  end

  private

  def set_params
    params.require(:range).permit(:period, :period_two)
  end

  def validate_date
    date_one = Date.new(set_params['period(1i)'].to_i,set_params['period(2i)'].to_i)
    date_two = Date.new(set_params['period_two(1i)'].to_i,set_params['period_two(2i)'].to_i)
    if date_one > date_two
      flash[:alert] = "Primer periodo no puede ser mayor que el segundo!. Vuelva a Buscar"
      redirect_to root_path
    else
      flash[:alert] = "Busqueda entre los periodos #{date_one} - #{date_two}."
    end
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
