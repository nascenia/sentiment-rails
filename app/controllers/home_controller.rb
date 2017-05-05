class HomeController < ApplicationController
  def index
    @users = User.all.where.not(id: current_user)
    @conversation = current_user.messages.try(:last).try(:conversation)
  end
end
