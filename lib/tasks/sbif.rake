namespace :sbif do
  desc 'task for insert data form sbif'
  task default_data: :environment do
    sbif = SbifService.new
    data = sbif.currency_duo('1998-01-01', Date.current)

    data.each do |d|
      ss = SettingSbif.where(date: d[:date]).first_or_create
      ss.uf = d[:uf] if d[:uf].present?
      ss.dolar = d[:dolar] if d[:dolar].present?
      ss.save
    end
  end

  desc 'insert data daily'
  task daily_setting: :environment do
    SettingSbifJob.perform_later
  end
end