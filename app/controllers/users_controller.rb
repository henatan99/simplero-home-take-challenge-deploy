class UsersController < ApplicationController
    # GET /posts or /posts.json
    def index
        @users = User.all
    end

    # GET /posts/1 or /posts/1.json
    def show
    end

    # GET /posts/new
    def new
        @usr = User.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts or /posts.json
    def create
        @user = User.new(user_params)

        respond_to do |format|
        if @post.save
            format.html { redirect_to user_url(@user), notice: "User was successfully created." }
            format.json { render :show, status: :created, location: @post }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
        respond_to do |format|
        if @user.update(user_params)
            format.html { redirect_to post_url(@user), notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
        @user.destroy

        respond_to do |format|
        format.html { redirect_to users_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_post
        @user = Post.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def user_params
        params.require(:user).permit(:email, :username, :first_name, :last_name)
        end
end
