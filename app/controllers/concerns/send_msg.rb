require 'bunny'

module SendMsg
  connection = Bunny.new "amqp://jtdwviby:Ap8KyZ5dQ2JCsZvUYVT33cFwZtJP28u6@salamander.rmq.cloudamqp.com/jtdwviby"
  connection.start
  puts "conexao com sucesso"


  channel = connection.create_channel


  fila=channel.queue('envios_tis', durable: true)

  while  1==1 do
    puts " Insira uma mensagem: "
    msg = gets
    channel.default_exchange.publish(msg, routing_key: fila.name)

    puts "Para sair, aperte ctrl+C"


  end
rescue Interrupt => _
  puts "\n saindo..."

  connection.close

  puts "\n pronto!"
  exit(0)

end

