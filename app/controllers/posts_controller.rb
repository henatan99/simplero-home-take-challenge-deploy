class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts or /posts.json
    def index
        @posts = Post.all
    end

    # GET /posts/1 or /posts/1.json
    def show
        @post = @group.posts.find(params[:id])
    end

    # GET /posts/new
    def new
        @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts or /posts.json
    def create
        @post = @group.posts.create!(params.require(:post).permit(:title, :content).merge(user_id: current_user.id, group_id: @group.id))
        user_permission = @group.users.include?(current_user) || current_user == @group.creator
        respond_to do |format|
        if user_permission && @post.save
            format.html { redirect_to group_posts_url(@post), notice: "Post was successfully created." }
            format.json { render :show, status: :created, location: @post }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
        user_permission = current_user == @post.user || current_user == @post.group.creator
        post_params = params.require(:post).permit(:title, :content).merge(user_id: current_user.id, group_id: @group.id)

        respond_to do |format|
        if user_permission && @post.update(post_params)
            format.html { redirect_to group_post_url(@post), notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @post }
        else
            format.html { render :edit, status: :unprocessable_entity, notice: "Post was not updated" }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
        user_permission = current_user == @post.user || current_user == @post.group.creator
        @post.destroy

        respond_to do |format|
        if user_permission
            format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
            format.json { head :no_content }
        else
            format.html { redirect_to post_url(@post), notice: "Permission denied." }
            format.json { head :no_content }
        end
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_post
            @post = Post.find(params[:id])
        end

        def set_group
            @group = Group.find(params[:group_id])
        end
end
