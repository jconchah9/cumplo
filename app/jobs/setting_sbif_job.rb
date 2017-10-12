class SettingSbifJob < ApplicationJob
  queue_as :jobs

  def perform
    data = SbifService.new.currency_duo(Date.current, Date.current)
    data.each do |d|
      ss = SettingSbif.where(date: d[:date]).first_or_create
      ss.uf = d[:uf] if d[:uf].present?
      ss.dolar = d[:dolar] if d[:dolar].present?
      ss.save
    end
  end
end
