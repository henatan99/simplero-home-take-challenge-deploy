class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post

    def create
        @comment = @post.comments.create!(comment_params.merge(user_id: current_user.id, post_id: @post.id))
        respond_to do |format|
            if @comment.save
                format.html { redirect_to group_post_comments_url(@comment), notice: "Comment was successfully created." }
                format.json { render :show, status: :created, location: @comment }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        all_comment_params = comment_params.merge(user_id: current_user.id, post_id: @post.id)
        @comment = Comment.find(params[:id])
        current_user_permission  = current_user == @comment.user || @post.group.users.include?(current_user)
        respond_to do |format|
        if current_user_permission && @comment.update(all_comment_params)
            format.html { redirect_to group_url(@comment), notice: "Group was successfully updated." }
            format.json { render :show, status: :ok, location: @comment }
        else
            format.html { render :edit, status: :unprocessable_entity, notice: "Group was not updated." }
            format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
        end
    end

    def show
    end

    private
        def set_post
            @post = Post.find(params[:post_id])
        end

        def comment_params
            params.require(:comment).permit(:content)
        end
end