class SettingSbifJob < ApplicationJob
  queue_as :default

  def perform
    sbif = SbifService.new
    data = sbif.range('uf', Date.current.year, Date.current.month, Date.current.year, Date.current.month)

    data.each do |d|
      ss = SettingSbif.where(date: d[:date]).first_or_create
      ss.uf = d[:value]
      ss.save
    end
    
    data = sbif.range('dolar', Date.current.year, Date.current.month, Date.current.year, Date.current.month)
    data.each do |x|
      ss = SettingSbif.where(date: x[:date]).first_or_create
      ss.dolar = x[:value]
      ss.save
    end
  end
end
