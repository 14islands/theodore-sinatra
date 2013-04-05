# this is myapp.rb referred to above
require 'sinatra'

set :port, 8081

#
# Top level pages
#

get "/" do	
	set_page("home", "Theodore", "")
	erb :index
end

get "/projects" do
	set_page("projects", "Projects - Theodore", "projects")
	erb :projects
end

get "/info" do
	set_page("info", "Info - Theodore", "info")
	erb :info
end

get "/notes" do
	set_page("notes", "Notes - Theodore", "notes")
	erb :notes
end

def set_page(id, title, nav_page)
	@site_id = id
	@title = title
	@nav_page = nav_page
end


#
# Projects
#

get "/projects/:id" do
	set_project(params[:id])
	
	if @project
		set_page("project", "#{@project[:title]} - Theodore", "projects")
		erb :"projects/#{@project[:id]}"
	else
		set_page("projects", "Projects - Theodore", "projects")
		erb :projects
	end
end

def set_project(id)
	
	# list of projects
	@projects = [
		{ id: "template",  title: "Template 1" },
		{ id: "template2", title: "Template 2" },
		{ id: "template3", title: "Template 3" }
	]	

	@projects.each_with_index do |p,i|
		if p[:id] == id
			logger.info "set #{p[:id]} is #{i}"
			
			# set active project
			@project = p
			@project_pos = i 
		end
	end
	
	return nil
end

def project_url(id)
	return "/projects/#{id}"
end

def project_prev?
	logger.info "project_prev? #{@project_pos}"
	if @project_pos > 0
		logger.info "project_prev? true"
		return true 
	end
	return false
end

def project_next?
	logger.info "project_next? #{@project_pos}"
	if @project_pos+1 < @projects.length
		logger.info "project_next? true"
		return true 
	end
	return false
end

def project_prev_url
	if project_prev?
		project = @projects[@project_pos-1] 
		return project_url(project[:id]) 
	end 
	return ""
end

def project_next_url
	if project_next?
		project = @projects[@project_pos+1] 
		return project_url(project[:id]) 
	end 
	return ""
end


#
# View Helpers
#

helpers do
	def nav_class(page)
		if page == @nav_page
			return 'class="selected"' 
		end
		return ""
	end
end
 
