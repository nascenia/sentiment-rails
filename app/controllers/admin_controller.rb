class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.where.not(id: current_user)
  end

  def check_sentiments
    start = DateTime.strptime(params[:start_date] , '%m/%d/%Y').beginning_of_day
    end_date = DateTime.strptime(params[:end_date], '%m/%d/%Y').end_of_day
    user = params[:user]
    tones = get_data(start, end_date, user)
    @chart_data = []
    if tones && tones['document_tone'] && tones['document_tone']['tones']
      tones['document_tone']['tones'].each do |tone_data|
        if tone_data['score'] > 0.5
          @chart_data << [tone_data['tone_name'], tone_data['score'].round(2)]
        end
      end
    end
    respond_to do |format|
      format.js {render layout: false}
    end

  end

  protected

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_to root_path
    end
  end


  def get_data(start, end_date, user)
    user = User.find user
    @user = user
    text = user.messages.between(start, end_date).map{|m| m.body}.join(" ")
    return nil if text.empty?

    url = 'https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2017-09-21'
    # auth = {:username => WATSON_USER, :password => WATSON_PASSWORD}
    auth = { username: 'apikey', password: WATSON_API_KEY }
    result = HTTParty.post(url,
                           basic_auth: auth,
                           body: { text: text }.to_json,
                           headers: { 'Content-Type' => 'application/json' })
    JSON.parse result.body
  end
end
