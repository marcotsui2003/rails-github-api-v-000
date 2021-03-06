class RepositoriesController < ApplicationController
  def index

    @username = session[:username]

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    binding.pry
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos",
      {name: params[:name]}.to_json, {
      'Accept' => 'application/json',
      'Authorization' => "token #{session[:token]}"
    }
    redirect_to root_path
  end
end
