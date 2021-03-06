class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@entry = Entry.find_by(id: params[:comment][:entry_id])
	  	@comment = @entry.comments.build(comment_params)
	  	@comment.user = current_user
	  	if @comment.save
	  		# redirect_to root_url #not js
		  	respond_to do |format|
		      format.html { redirect_to :back}
		      format.js
	    	end
	    end
	end

	def destroy
		Comment.find(params[:id]).destroy
		# redirect_to request.referrer || root_url #not js
		respond_to do |format|
			format.html {redirect_to(request.referrer || root_url)}
			format.js
		end
	end

	private
	    def comment_params
	      params.require(:comment).permit(:content, :entry_id, :user_id)
	    end
	    	
	    def correct_user
	      @comment = current_user.comments.find_by(id: params[:id])
	      redirect_to root_url if @comment.nil?
	    end 
end
