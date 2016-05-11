class PostsController < ApplicationController
	#?class is plural of Posts bc the model was post.rb...its part of what class? the Application Controller
	before_action :set_post, only: [:update, :edit, :destroy]

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			@post.create_activity key: "post.created", owner: @post.user
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username, notice: "Post Created!")}
			end
		else
			redirect_to user_path(@post.user.username), notice: "Something went wrong."
		end
	end


	def edit
		
	end


	def update
		if @post.update(post_params)
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username), notice: "Post updated"}
			end
		else
			redirect_to user_path(@post.user.username), notice: "Something went wrong."
		end
	end
	# anytime we Create or Update, we want to do it with the post_params)

	
	def destroy
		@post.destroy 
		respond_to to do |format|
			format.html {redirect_to user_path(@post.user.username), notice: "Post Deleted"}
		end	
	end


	private

	def set_post
		@post = Post.find(params [:id])
		
	end

	def post_params
		params.require(:post).permit(:content)
	end



end
