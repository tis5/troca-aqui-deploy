require 'swagger_helper'

describe 'Pessoas' do
  
  path '/pessoas' do
    post 'Cria pessoa' do
      tags 'Pessoas'
      consumes 'application/json', 'application/xml'

      parameter name: :Pessoa, in: :body, schema:{
          type: :object,
          properties: {
            nome: { type: :string },
            email: {type: :string },
            cidade: {type: :string },
            data_nasc: {type: :datetime },
            telefone: {type: :string}
          },
          required: %w[nome email cidade data_nasc telefone ]

      }

      response '201', 'Pessoa created' do
        let(:pessoa) { { nome: 'Teste', email: 'teste@gmail.com', cidade: 'BH', data_nasc:'2008-10-23 18:52:47.513', telefone: '3193313333'}}
        run_test!
      end

      response '422', 'invalid request' do
        let(:pessoa) { { nome: 'Teste', email: 'teste@gmail.com', data_nasc:'2008-10-23 18:52:47.513', telefone: '3193313333'} }
        run_test!
      end


    end

  end

  path '/pessoas/{id}' do

    get 'Retorna pessoa' do
      tags 'Pessoas'
      consumes 'application/json', 'application/xml'

      parameter name: :id, :in => :path, :type => :string

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                       nome: { type: :string },
                       email: {type: :string },
                       cidade: {type: :string },
                       data_nasc: {type: :datetime },
                       telefone: {type: :string}
                   },
                   required: %w[nome email cidade data_nasc telefone ]

        let(:id) { Pessoa.create(name:"Pessoa", email: "parker@hotmail.com", cidade: "BeloriHills",data_nasc: "2019-09-24 20:21:41.710000",telefone: "32 3142-5151").id }
        run_test!
    end
    end

     put 'Altera pessoa' do
      tags 'Pessoas'
      consumes 'application/json', 'application/xml'

      parameter name: :id, :in => :path, :type => :string
      parameter name: :Pessoa, in: :body, schema:{
          type: :object,
          properties: {
              nome: { type: :string },
              email: {type: :string },
              cidade: {type: :string },
              data_nasc: {type: :datetime },
              telefone: {type: :string}
          },

      }

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   nome: { type: :string },
                   email: {type: :string },
                   cidade: {type: :string },
                   data_nasc: {type: :datetime },
                   telefone: {type: :string}
               },
               required: %w[]

        let(:id) { Pessoa.update(
            nome: :nome,
            email: :email,
            cidade: :cidade,
            data_nasc: :data_nasc,
            telefone: :telefone
            ) }
        run_test!
        end
      end


    delete 'Deleta pessoa' do
      tags 'Pessoas'
      consumes 'application/json', 'application/xml'

      parameter name: :id, :in => :path, :type => :string

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   nome: { type: :string },
                   email: {type: :string },
                   cidade: {type: :string },
                   data_nasc: {type: :datetime },
                   telefone: {type: :string}
               },
               required: %w[nome email cidade data_nasc telefone ]

        let(:id) { Pessoa.delete(Pessoa.all.first.id) }
        run_test!
      end
    end

  end
end


