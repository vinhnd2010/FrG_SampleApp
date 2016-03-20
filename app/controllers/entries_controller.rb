class EntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = "Entry created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
		Entry.find(params[:id]).destroy
		flash[:success] = "Entry deleted"
		redirect_to request.referrer || root_url
	end

	private
		def entry_params
			params.require(:entry).permit(:title, :content)
		end
end
