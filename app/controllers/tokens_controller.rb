class TokensController < ApplicationController
  before_action :set_token, only: [:show, :update, :destroy]

  # GET /tokens
  def index
    @tokens = Token.all

    render json: @tokens
  end

  # GET /tokens/1
  def show
    render json: @token
  end

  # GET /tokenpessoa/1
  def showpessoa
    @token= Token.find_by(pessoa_id: params[:pessoa_id])
    render json: @token
  end


  # POST /tokens
  def create
    @token= Token.new(token_params)

    if @token.save
      render json: @token, status: :created, location: @token
    else
      render json: @token.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tokens/pID
  def update

    @token=Token.find_by(pessoa_id: params["token"][:pessoa_id])

    if @token.update(token: params["token"][:token])
      render json: @token
    else
      render json: @token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tokens/1
  def destroy
    @token.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.require(:token).permit(:token, :pessoa_id)
    end
end
