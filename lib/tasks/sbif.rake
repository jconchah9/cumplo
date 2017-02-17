namespace :sbif do
  desc 'task for insert data form sbif'
  task default_data: :environment do
    sbif = Sbif.new
    sbif.range('uf',1998,1,Date.current.year,Date.current.month)
    data = sbif.data
    data.each do |d|
      if SettingSbif.where(date: d[:date]).count.positive?
        ss = SettingSbif.find_by(date: d[:date])
        ss.update_columns(uf: d[:value])
        puts "update uf : #{d}"
      else
        SettingSbif.create(date: d[:date], uf: d[:value])
        puts "create uf : #{d}"
      end
    end
    sbif.range('dolar',1998,1,Date.current.year,Date.current.month)
    data = sbif.data
    data.each do |x|
      if SettingSbif.where(date: x[:date]).count.positive?
        ss = SettingSbif.find_by(date: x[:date])
        ss.update_columns(dolar: x[:value])
        puts "update dolar : #{x}"
      else
        SettingSbif.create(date: x[:date], dolar: x[:value])
        puts "create dolar : #{x}"
      end
    end
  end

  desc 'insert data daily'
  task daily_setting: :environment do
    SettingSbifJob.perform_now
  end

end
