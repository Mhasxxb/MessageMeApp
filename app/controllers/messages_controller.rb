class  MessagesController < ApplicationController

before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'chatroom_channel', 
                                    mod_msg: render_message(message)
    else
      flash[:error] = "Message is invalid."
      redirect_to root_path
    end
  
  end

private

  def message_params
    params.require(:message).permit(:body)
  end

  def render_message(message)
    render(partial: "message", locals: {message: message})
  end
end