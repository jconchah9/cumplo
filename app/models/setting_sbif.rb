class SettingSbif < ApplicationRecord
  scope :between, -> (start_at = '1998-01-01', end_at = (Date.current - 1.day) ) { where('date between ? and ?', start_at.beginning_of_month.strftime('%Y-%m-%d'), end_at.end_of_month.strftime('%Y-%m-%d')) }

  def self.min_max(data, method = 'minimum', currency = 'uf')
    result = data.send(method,(currency.to_sym))
  end

  def self.avg(data, currency = 'uf')
    result = data.average(currency.to_sym).to_f.round(2)
  end

  def self.chart_data(data, currency = 'uf')
    chart = []
    data.map { |x| chart << [x[:date], x[currency.to_sym]] if x[currency.to_sym].present?  }
    chart
  end
end
