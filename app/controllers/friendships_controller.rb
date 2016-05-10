class FriendshipsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_user, only: [:create]
	before_action :set_friendship, only: [:destroy, :accept]

	#any time there is a callback up here, you have to make the method below. 

	def create
		@friendship = current_user.request_friendship(@user)
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Created"}
		end

	end

	def destroy
		@friendship.destroy
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Ended"}
		end

	end

	def accept
		@friendship.accept_friendship
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.user, recipient: @friendship.friend
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.friend, recipient: @friendship.user
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Accepted!"}
		end
	end

#this isnt a view...and the only method here not part of crud is accept. Its an ACTION (thats not a view) - so we are deviating from restful design. 

private

def set_user
	@user = User.find(params[:user_id])
	
end

def set_friendship
	@friendship = Friendship.find(params[:id])
	
end

end
