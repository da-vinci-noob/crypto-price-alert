class ProcessAlertJob
  include Sidekiq::Job
  queue_as :send_alerts

  def perform(*args)
    ws = WebSocket::Client::Simple.connect 'wss://stream.binance.com:9443/ws/btcusdt@ticker'
    # Listen for price updates
    ws.on :message do |msg|
      prices = JSON.parse(msg.data)
      ReadCache.redis.SMEMBERS('target_alerts').each do |alert|
        alert_data = JSON.parse(alert)
        target_price = alert_data['target_price'].to_f
        if target_price.public_send(alert_data['operator_check'], prices['c'].to_f)
          alert_obj = PriceAlert.includes(:user).find(alert_data['id'])
          UserMailer.price_alert(alert_obj).deliver_later
          alert_obj.status_triggered!
          ReadCache.redis.SREM('target_alerts', alert)
        end
      end
    end
    loop do
      return if ws.closed?
    end
  end
end
