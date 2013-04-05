# this is myapp.rb referred to above
require 'sinatra'

set :port, 8080

get "/" do	
	set_page("home", "Theodore", "")
	erb :index
end

get "/projects" do
	set_page("projects", "Projects - Theodore", "projects")
	erb :projects
end

get "/projects/:name" do
	set_page("project-details", "Projects - Theodore", "projects")
	erb :"projects/#{params[:name]}"
end

get "/info" do
	set_page("info", "Info - Theodore", "info")
	erb :info
end

get "/notes" do
	set_page("notes", "Notes - Theodore", "notes")
	erb :notes
end


#
# Helpers
#

helpers do
	def set_page(id, title, nav_page)
		@site_id = id
		@title = title
		@nav_page = nav_page
	end
	def nav_class(page)
		if page == @nav_page
			return 'class="selected"' 
		end
		return ""
	end
end
 
