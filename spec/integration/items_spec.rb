require 'swagger_helper'

describe 'Items' do
  path '/items' do
    post 'Creates an item' do
      tags 'Items'
      consumes 'application/json', 'application/xml'

      parameter name: :Item, in: :body, schema: {
          type: :object,
          properties: {
              nome: { type: :string },
              categoria: {type: :string },
              valor_aprox: {type: :float },
              desejo: {type: :string },
              quant:{type: :integer},
              pessoa_id: {type: :integer},
              disp: { type: :boolean }
          },
          required: %w[ nome categoria valor_aprox desejo quant pessoa_id disp]
      }

      response '201', 'Item created' do
        let(:item) { { nome: 'Teste', categoria: 'Essa', valor_aprox: '24.76', desejo: 'Tal', quant: 3, pessoa_id: 1, disp: true} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:item) { { nome: 1, categoria: true, valor_aprox: abc, desejo: 'Tal', quant: 3, pessoa_id: 1, disp: true} }
        run_test!
      end


    end
  end

  path '/items/{id}' do

    get 'Retorna item' do
      tags 'Items'
      consumes 'application/json', 'application/xml'

      parameter name: :id, :in => :path, :type => :string

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   type: :object,
                   properties: {
                       nome: { type: :string },
                       categoria: {type: :string },
                       valor_aprox: {type: :float },
                       desejo: {type: :string },
                       quant:{type: :integer},
                       pessoa_id: {type: :integer},
                       disp: { type: :boolean }
                   },
                   required: %w[ nome categoria valor_aprox desejo quant pessoa_id disp]
               }

        let(:id) { Item.create(name:"Item", categoria: "algumacoisa", valor_aprox:12.09,desejo: "celular", quant:1, pessoa_id: Pessoa.all.first.id,disp: true).id }
        run_test!
      end
    end

    delete 'Deleta item' do
      tags 'Items'
      consumes 'application/json', 'application/xml'

      parameter name: :id, :in => :path, :type => :string

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   nome: { type: :string },
                   categoria: {type: :string },
                   valor_aprox: {type: :float },
                   desejo: {type: :string },
                   quant:{type: :integer},
                   pessoa_id: {type: :integer},
                   disp: { type: :boolean }
               },
               required: %w[nome categoria valor_aprox desejo quant pessoa_id disp]

        let(:id) { Item.delete(Item.all.first.id) }
        run_test!
      end
    end

  end



end