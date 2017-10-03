class SbifService
  include HTTParty

  base_uri 'http://api.sbif.cl'

  def initialize
    @api_key = ENV['SBIF_API_KEY']
    @response = nil
  end

  def range(resource, year, month, year2, month2)
    @response = self.class.get("/api-sbifv3/recursos_api/#{resource}/periodo/#{year}/#{month}/#{year2}/#{month2}?apikey=#{@api_key}&formato=xml")
    @response = response(resource)
    data
  end

  private

  def response(resource)
    resource =
      case resource
      when 'uf'
        symbolize_keys_deep!(@response)[:indicadores_financieros][:u_fs][:uf]
      when 'dolar'
        symbolize_keys_deep!(@response)[:indicadores_financieros][:dolares][:dolar]
      end
    resource
  end

  def data
    data = @response.map do |x|
      { date: x['Fecha'], value: value_format(x['Valor']) }
    end
    data
  end

  def value_format(value)
    value = value.tr('.', '').tr(',', '.').to_f
    value
  end

  def symbolize_keys_deep!(h)
    h.keys.each do |k|
      ks    = k.underscore.to_sym
      h[ks] = h.delete k
      symbolize_keys_deep! h[ks] if h[ks].is_a? Hash
    end
    h
  end
end
