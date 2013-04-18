module ApplicationHelper

  def logo
    image_tag("hidrovia.gif", :alt => "taesa", :class => "round")
  end

  def title
    base_title = "COPRE"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
