module ApplicationHelper
  def make_options
    Make.all.map{ |u| [ u.name, u.webmotors_id ] }
  end
end
