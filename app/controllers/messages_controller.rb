class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.json { render :show, status: :created, location: @message }
        format.js {}
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :text_content)
  end
end
