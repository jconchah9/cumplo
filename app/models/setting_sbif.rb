class SettingSbif < ApplicationRecord

  def self.between(start_at, end_at)
    start_at = start_at.beginning_of_month.strftime('%Y-%m-%d')
    end_at = end_at.end_of_month.strftime('%Y-%m-%d')
    data = where('date between ? and ?', start_at, end_at)
    data
  end

  def self.chart_data(data, currency = 'uf')

    data = data.map { |x| [x[:date], x[currency.to_sym]] if x[currency.to_sym].present? }.compact

  end
end