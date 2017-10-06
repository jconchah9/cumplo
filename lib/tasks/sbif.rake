namespace :sbif do
  desc 'task for insert data form sbif'
  task default_data: :environment do
    sbif = SbifService.new
    data = sbif.range('uf', 1998, 1, Date.current.year, Date.current.month)

    data.each do |d|
      ss = SettingSbif.where(date: d[:date]).first_or_create
      ss.uf = d[:value]
      ss.save
    end

    data = sbif.range('dolar', 1998, 1, Date.current.year, Date.current.month)

    data.each do |x|
      ss = SettingSbif.where(date: x[:date]).first_or_create
      ss.dolar = x[:value]
      ss.save
    end
  end

  desc 'insert data daily'
  task daily_setting: :environment do
    SettingSbifJob.perform_now
  end
end
