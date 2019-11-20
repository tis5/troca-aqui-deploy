require 'bunny'
class ReceiveMsg

  connection = Bunny.new "amqp://jtdwviby:Ap8KyZ5dQ2JCsZvUYVT33cFwZtJP28u6@salamander.rmq.cloudamqp.com/jtdwviby"

  connection.start

  channel = connection.create_channel


  fila=channel.queue('envios_tis', durable: true)


  begin
    puts ' [*] Aguardando mensagens. Para sair pressione CTRL+C'

    fila.subscribe(block: true) do |_delivery_info, _properties, body|
      puts " [x] Nova msg:  #{body}"
    end
  rescue Interrupt => _
    puts "\n saindo..."

    connection.close

    puts "\n pronto!"

    exit(0)
  end

end

