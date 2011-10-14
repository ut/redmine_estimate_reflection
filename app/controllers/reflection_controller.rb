class ReflectionController < ApplicationController
  unloadable



  def index
    @projects = Project.find(:all)
  end


  def show
    @project = Project.find_by_id(params[:id])
    @versions = Version.find_all_by_project_id(@project)
    @issues = Issue.find_all_by_project_id(@project)
    
    @max = 0
    @min = 99999
    
    @total_estimate = 0
    @total_spent = 0
    
    @versions.each do |v|
      @issues.each do  |i|
        if i.fixed_version_id == v.id
          diff = i.estimated_hours - i.spent_hours
          @max = diff if diff > @max  
          @min = diff if diff < @min
          @total_estimate = @total_estimate + i.estimated_hours
          @total_spent = @total_spent + i.spent_hours  
          
        end
      end
    end
    
  end

end
