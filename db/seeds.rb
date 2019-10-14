# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if (Rails.env.development?)

items = [
    [ "Celular", "Eletrônico", 3500.00, "livros",3,1,true],
    [ "Halliday livro","Livro",24.90, "celular",1,1,false],
    [ "Livro Teste", "Livro",20.99,"livros", 1,1,true ]
]

pessoas = [
    ["Peter","parker@hotmail.com","BeloriHills","2019-09-24 20:21:41.710000","32 3142-5151"],
    ["Aqualung","parker@hotmail.com","BeloriHills","2019-09-24 20:21:41.710000","32 3142-5151"]
]



items.each do |nome,categoria,valor_aprox,desejo,quant,pessoa_id,disp|
  Item.find_by_nome(nome)?puts("Já existe item com nome: ",nome): Item.create( nome: nome, categoria:categoria,valor_aprox:valor_aprox,desejo:desejo,quant:quant,pessoa_id:pessoa_id,disp:disp);
end


pessoas.each do | nome, email, cidade,data_nasc,telefone|
  Pessoa.find_by_nome(nome)? puts("Já existe Pessoa com o nome: ",nome) : Pessoa.create(nome:nome,email:email,cidade:cidade,data_nasc:data_nasc,telefone:telefone)
end

end