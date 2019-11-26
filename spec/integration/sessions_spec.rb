require 'swagger_helper'

describe 'Login' do

  path '/sessions' do
    post 'realiza o login - para testar passar o user' do
      tags 'Login'
      consumes 'application/json', 'application/xml'

      parameter name: :User, in: :body, schema: {
          type: :object,
          properties: {
                  email: {type: :string},
                  password: {type: :string}

          },
          required: %w[ email password]
      }

      response '201', 'Login Ok' do
        let(:user) { { "email": "teste1@gma.com", "password": "algumacoisa"} }
        run_test!
      end

    end
  end


end
