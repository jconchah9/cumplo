module Utils
  module Calculator
    CURRENCY = %i(uf dolar)
    class Currency

      attr_reader :result

      def initialize(data)
        @result = {}
        currency_average(data)
        currency_min_max(data)
      end

      private

      def currency_average(data)
        response = {}
        CURRENCY.each do |currency|
          lote = data.map { |x| x.send(currency) }.compact
          @result[currency] = { avg: (lote.reduce(:+) / lote.size).round(2) }
        end
        response
      end

      def currency_min_max(data)
        CURRENCY.each do |currency|
          min_max = data.map { |x| x.send(currency) }.compact.minmax
          @result[currency].merge!(min: min_max[0], max: min_max[1])
        end
      end
    end
  end
end