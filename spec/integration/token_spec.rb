require 'swagger_helper'

describe 'Token do celular' do

  path '/tokens' do
    post 'Cria novo token' do
      tags 'Token'
      consumes 'application/json'
      parameter name: :Token, in: :body, schema: {
          type: :object,
          properties: {
              token:{type: :string},
              pessoa_id: {type: :integer}
          },
          required: %w[ token pessoa_id]
      }

      response '201', 'Item created' do
        let(:token) {  {token: :token,
                        pessoa_id: :pessoa_id}  }
        run_test!
      end

    end

  end

  path '/tokens/{id}' do
    put 'Altera Token' do
      tags 'Token'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :Token, in: :body, schema:{
          type: :object,
          properties: {
              token: {type: :string},
              pessoa_id: {type: :integer}
          }

      }

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   token: {type: :string},
                   pessoa_id: {type: :integer}
               },
               required: %w[]

        let(:Token) { Token.update( token: :token,
                                    pessoa_id: :pessoa_id
        ) }
        run_test!
      end
    end
  end

  path '/tokenpessoa/{pessoa_id}' do
    get 'Retorna token de pessoa' do
      tags 'Token'
      consumes 'application/json', 'application/xml'

      parameter name: :pessoa_id, :in => :path, :type => :string

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                   type: :object,
                   properties: {
                       token: { type: :string },
                       pessoa_id: {type: :integer},
                   },
                   required: %w[ ]
               }

        let(:id) { Token.find_by(pessoa_id: :pessoa_id).id}
        run_test!
      end
    end


  end

end
