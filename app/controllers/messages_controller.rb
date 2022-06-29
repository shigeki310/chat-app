class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(messsage_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @masseges = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def messsage_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end