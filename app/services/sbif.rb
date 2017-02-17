class Sbif
  include HTTParty

  base_uri 'http://api.sbif.cl/'

  def initialize
    @api_key = ENV['SBIF_API_KEY']
    @response = nil
  end

  def range(resource ,year, month, year2, month2)
    @response = self.class.get("/api-sbifv3/recursos_api/#{resource}/periodo/#{year}/#{month}/#{year2}/#{month2}?apikey=#{@api_key}&formato=xml")
    @response = self.response(resource)
  end

  def data
    data = []
    @response.map { |x| data += [ date: x['Fecha'], value: x['Valor'].gsub('.','').gsub(',','.').to_f ] }
    data
  end

  def response(resource)
    response = case resource
                when 'uf' then self.symbolize_keys_deep!(@response)[:indicadores_financieros][:u_fs][:uf]
                when 'dolar' then self.symbolize_keys_deep!(@response)[:indicadores_financieros][:dolares][:dolar]
                end
  end

  def symbolize_keys_deep!(h)
   h.keys.each do |k|
       ks    = k.underscore.to_sym
       h[ks] = h.delete k
       symbolize_keys_deep! h[ks] if h[ks].kind_of? Hash
   end
   h
 end
end
