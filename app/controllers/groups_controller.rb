class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group, only: [:show, :edit, :update, :destroy]
    # GET /posts or /posts.json
    def index
        @groups = Group.all
        # @created_groups = Group.where(creator: current_user)
        # @member_groups = Group.where(include?(:creator))
        @group = Group.new
        @membership = Membership.new
    end

    # GET /posts/1 or /posts/1.json
    def show
    end

    # GET /posts/new
    def new
        @group = Group.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts or /posts.json
    def create
        @group = Group.new group_params.merge(user_id: current_user.id)

        respond_to do |format|
        if @group.save
            format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
            format.json { render :show, status: :created, location: @group }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @group.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
        all_group_params = group_params.merge(user_id: current_user.id)
        current_user_permission  = current_user == @group.creator || @group.users.include?(current_user)
        respond_to do |format|
        if current_user_permission && @group.update(all_group_params)
            format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
            format.json { render :show, status: :ok, location: @group }
        else
            format.html { render :edit, status: :unprocessable_entity, notice: "Group was not updated." }
            format.json { render json: @group.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
        if current_user_permission  = current_user == @group.creator || @group.users.include?(current_user)
            @group.destroy
            respond_to do |format|
                format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
                format.json { head :no_content }
            end
        else 
            respond_to do |format|
                format.html { redirect_to group_url(@group), notice: "Permission denied." }
                format.json { head :no_content }
            end
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_group
            @group = Group.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def group_params
            params.require(:group).permit(:name)
        end
end
