set :output, 'log/whenever.log'
ENV.each { |k, v| env(k, v) }

every 1.minute do
  command 'bundle exec rake sbif:daily_setting'
end
