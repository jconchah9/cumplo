set :output, 'log/whenever.log'

every '05 03 * * *' do
 rake "sbif:setting_day"
end

end
