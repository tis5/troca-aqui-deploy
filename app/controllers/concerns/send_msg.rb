require 'bunny'

module SendMsg
  connection = Bunny.new(
      :host => "35.238.95.239",
      :port => 5672,
      :vhost => "/",
      :user => "sadminmq",
      :pass => "eFJ1Na1Gp45a")
  connection.start


  channel = connection.create_channel


  fila=channel.queue('envios_tis', durable: true)


  channel.default_exchange.publish('Olá Mundo', routing_key: fila.name)

  connection.close

  puts "ok"

end
