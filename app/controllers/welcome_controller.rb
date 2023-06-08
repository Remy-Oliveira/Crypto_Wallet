class WelcomeController < ApplicationController
  def index
    @params_palavra = params[:palavra]
    cookies[:curso] = "eu sou o cookie criado no controller welcome#index"
  end
end
