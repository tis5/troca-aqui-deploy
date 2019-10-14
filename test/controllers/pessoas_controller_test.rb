require 'test_helper'

class PessoasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pessoa = pessoas(:one)
  end

  test "should get index" do
    get pessoas_url, as: :json
    assert_response :success
  end

  test "should create pessoa" do
    assert_difference('Pessoa.count') do
      post pessoas_url, params: { pessoa: { cidade: @pessoa.cidade, data_nasc: @pessoa.data_nasc, email: @pessoa.email, nome: @pessoa.nome, telefone: @pessoa.telefone } }, as: :json
    end

    assert_response 201
  end

  test "should show pessoa" do
    get pessoa_url(@pessoa), as: :json
    assert_response :success
  end

  test "should update pessoa" do
    patch pessoa_url(@pessoa), params: { pessoa: { cidade: @pessoa.cidade, data_nasc: @pessoa.data_nasc, email: @pessoa.email, nome: @pessoa.nome, telefone: @pessoa.telefone } }, as: :json
    assert_response 200
  end

  test "should destroy pessoa" do
    assert_difference('Pessoa.count', -1) do
      delete pessoa_url(@pessoa), as: :json
    end

    assert_response 204
  end
end
