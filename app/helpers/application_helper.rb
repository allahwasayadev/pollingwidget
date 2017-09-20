module ApplicationHelper

  def active_class(contr,act)
    current_page?(controller: contr, action: act) ? "active" : ""
  end

  def to_boolean(str)
    str == 'true'
  end

end
