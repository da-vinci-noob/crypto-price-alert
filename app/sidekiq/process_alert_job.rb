class ProcessAlertJob
  include Sidekiq::Job

  def perform(*args)
    ws = WebSocket::Client::Simple.connect 'wss://stream.binance.com:9443/ws/btcusdt@ticker'
    # Listen for price updates
    ws.on :message do |msg|
      prices = JSON.parse(msg.data)
      puts "Alerts Count: #{PriceAlert.status_created.count}"
      PriceAlert.status_created.each do |alert|
        binding.pry
        target_price = alert.target_price.to_f
        alert.status_triggered! if target_price.public_send(alert.operator_check, prices['c'].to_f)
      end
    end
    loop do
      return if ws.closed?
    end
  end
end
