class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.where.not(id: current_user)
  end

  def check_sentiments
    start = DateTime.strptime(params[:start_date] , '%m/%d/%Y').beginning_of_day
    end_date = DateTime.strptime(params[:end_date], '%m/%d/%Y').end_of_day
    user = params[:user]
    @tones = get_data(start, end_date, user)
  end

  protected

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_to root_path
    end
  end


  def get_data(start, end_date, user)
    user = User.find user
    text = user.messages.between(start, end_date).map{|m| m.body}.join(" ")
    # text = user.messages.map{|m| m.body}.join(" ")
    return nil if text.empty?
    url = 'https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2016-05-19'
    auth = {:username => "abbb6f1f-b5f6-4f81-8c12-6bea6b7c6ffb", :password => "A7nIFyC3mcvy"}
    result = HTTParty.post(url,
                           :body => { :text => text }.to_json,
                           :basic_auth => auth,
                           :headers => { 'Content-Type' => 'application/json' } )
    JSON.parse result.body

  end


end


