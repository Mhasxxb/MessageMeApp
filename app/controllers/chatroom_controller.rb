class ChatroomController < ApplicationController
  def index
    if logged_in?
      @message = Message.new
      @messages = Message.all
    else
      redirect_to login_path
    end

  end
end