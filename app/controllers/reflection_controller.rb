class ReflectionController < ApplicationController
  unloadable
  
  before_filter :find_project, :authorize, :only => [:index,:show]



  def index
    @projects = Project.find(:all)
  end


  def show

    @versions = Version.find_all_by_project_id(@project)
    @issues = Issue.find_all_by_project_id(@project)
    
    @max = 0
    @min = 99999
    
    @total_estimate = 0
    @total_spent = 0
    @total_done = 0
    
    if @versions
      @versions.each do |v|
        @issues.each do  |i|
          i.estimated_hours = 0 if i.estimated_hours.blank? 
          if i.fixed_version_id == v.id
            diff = i.estimated_hours - i.spent_hours
            @max = diff if diff > @max  
            @min = diff if diff < @min
            @total_estimate = @total_estimate + i.estimated_hours
            @total_spent = @total_spent + i.spent_hours  
            @total_done = @total_done + i.done_ratio
            
          end
        end
      end
    end 
    if @issues.size > 0
      @total_done = @total_done / @issues.size
    end
       
  end
  
  private
  
  def find_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    elsif params[:id]
      @project = Project.find(params[:id])
    end
    @projects = Project.find(:all)
  end
end
