class HomeController < ApplicationController
before_action :authenticate_account!
before_action :validate_date, only: [:search]

  def index
  end

  def search
    sbif = Sbif.new
    sbif.range('uf',set_params['period(1i)'],set_params['period(2i)'],set_params['period_two(1i)'],set_params['period_two(2i)'])
    @uf_min = sbif.min_max('min')
    @uf_max = sbif.min_max('max')
    @uf_data = sbif.chart_data
    @uf_avg = sbif.average.round(2)
    sbif.range('dolar',set_params['period(1i)'],set_params['period(2i)'],set_params['period_two(1i)'],set_params['period_two(2i)'])
    @dolar_min = sbif.min_max('min')
    @dolar_max = sbif.min_max('max')
    @dolar_avg = sbif.average.round(2)
    @dolar_data = sbif.chart_data
  end

  private

  def set_params
    params.require(:range).permit(:period, :period_two)
  end

  def validate_date
    date_one = Date.new(set_params['period(1i)'].to_i,set_params['period(2i)'].to_i)
    date_two = Date.new(set_params['period_two(1i)'].to_i,set_params['period_two(2i)'].to_i)
    if date_one > date_two
      flash[:danger] = "Primer periodo no puede ser mayor que el segundo!. Vuelva a Buscar"
      redirect_to root_path
    else
      flash[:notice] = "Busqueda entre los periodos #{date_one} - #{date_two}."
    end
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
