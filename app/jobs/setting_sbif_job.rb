class SettingSbifJob < ApplicationJob
  queue_as :default

  def perform
    sbif = Sbif.new
    sbif.range('uf',Date.current.year,Date.current.month,Date.current.year,Date.current.month)
    data = sbif.data
    data.each do |d|
      if SettingSbif.where(date: d[:date]).count.positive?
        ss = SettingSbif.find_by(date: d[:date])
        ss.update_columns(uf: d[:value])
        puts "SettingSbifJob update uf : #{d}"
      else
        SettingSbif.create(date: d[:date], uf: d[:value])
        puts "SettingSbifJob create uf : #{d}"
      end
    end
    sbif.range('dolar',Date.current.year,Date.current.month,Date.current.year,Date.current.month)
    data = sbif.data
    data.each do |x|
      if SettingSbif.where(date: x[:date]).count.positive?
        ss = SettingSbif.find_by(date: x[:date])
        ss.update_columns(dolar: x[:value])
        puts "SettingSbifJob update dolar : #{x}"
      else
        SettingSbif.create(date: x[:date], dolar: x[:value])
        puts "SettingSbifJob create dolar : #{x}"
      end
    end
  end
end
