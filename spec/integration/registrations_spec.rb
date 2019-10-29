require 'swagger_helper'
describe 'Cadastro' do

  path '/registrations' do
    post 'realiza o cadastro' do
      tags 'Cadastro'
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
        let(:user) { { "email": "teste1@email.com", "password": "algumacoisa"} }
        run_test!
      end

    end
  end
end