require 'bunny'

module ReceiveMsg
  connection = Bunny.new(
      :host => "35.238.95.239",
      :port => 5672,
      :vhost => "/",
      :user => "sadminmq",
      :pass => "eFJ1Na1Gp45a")

  connection.start

  channel = connection.create_channel


  fila=channel.queue('envios_tis', durable: true)


  channel.default_exchange.publish('Hello World, again!', routing_key: fila.name)

  begin
    puts ' [*] Waiting for messages. To exit press CTRL+C'

    fila.subscribe(block: true) do |_delivery_info, _properties, body|
      puts " [x] Received #{body}"
    end
  rescue Interrupt => _
    connection.close

    exit(0)
  end

end

