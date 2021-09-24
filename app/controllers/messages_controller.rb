class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  around_action :using_regional_replica, only: :index

  # GET /messages
  def index
    @messages = Message.all.includes(:user).order(:created_at).reverse_order.limit(10)
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
      render operations: cable_car.
        append("#messages", partial("messages/message", locals: { message: @message }))
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      using_regional_replica do
        @message = Message.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
