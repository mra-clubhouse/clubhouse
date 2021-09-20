class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash.now[:success] = 'Comment was successfully created.'

      render operations: cable_car.
        append("#comments", partial("comments/comment", locals: { comment: @comment })).
        replace("#flashes", partial("layouts/flashes", locals: { flashes: flash })).
        set_value(selector: "#comment_body", value: "")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, success: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
