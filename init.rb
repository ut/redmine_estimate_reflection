require 'redmine'

Redmine::Plugin.register :redmine_estimate_reflection do
  name 'Redmine Estimate Reflection plugin'
  author 'Ulf Treger'
  description 'Plugin to reflect estimate time and spent time'
  version '0.0.1'
  url ''
  author_url 'mailto:ulf.treger@googlemail.com'
  
  permission :view_all_reflections, :reflection => :index
  permission :view_project_reflection, :reflection => :show
  menu :project_menu, :redmine_estimate_reflection, { :controller => 'reflection', :action => "show" }, :caption => "Reflection", :after => "wiki", :param => :project_id
end
