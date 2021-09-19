class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.all.includes(:user).order(:created_at).reverse_order.limit(10)
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
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

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to @message, success: 'Message was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to messages_url, notice: 'Message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
