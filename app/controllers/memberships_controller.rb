class MembershipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group

    def create
        @membership = @group.memberships.create!(user_id: current_user.id, group_id: @group.id)

        respond_to do |format|
            if @membership.save
                format.html { redirect_to group_memberships_url(@membership), notice: "Membership was successfully created." }
                format.json { render :show, status: :created, location: @membership }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @membership.errors, status: :unprocessable_entity }
            end
        end
    end

    private
        def set_group
            @group = Group.find(params[:group_id])
        end

end

