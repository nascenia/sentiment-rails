class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.where.not(id: current_user)
  end

  def check_sentiments
    start = params[:start_date]
    end_date = params[:end_date]
    user = params[:user]
    @tones = get_data(start, end_date, user)
  end

  def get_data(start, end_date, user)

    url = 'https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2016-05-19'
    auth = {:username => "abbb6f1f-b5f6-4f81-8c12-6bea6b7c6ffb", :password => "A7nIFyC3mcvy"}
    # response = HTTParty.get(url, :basic_auth => auth)
    # JSON.parse response.body

    result = HTTParty.post(url,
                            :body => { :text => 'This is the screen name' }.to_json,
                            :basic_auth => auth,
                            :headers => { 'Content-Type' => 'application/json' } )
    JSON.parse result.body

  end

  protected

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_to root_path
    end
  end


end


