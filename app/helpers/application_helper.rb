# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def form_buttons(path_to_back)
    "<li class=\"form-buttons\">
    <button type=\"submit\" class=\"positive\">
      #{image_tag 'icons/tick.png', :alt => t('general.ok'), :title => t('general.ok')}<span>#{t'general.ok'}</span>
    </button>
      #{link_to image_tag('icons/cross.png', :alt => t('general.cancel')) + 'Volver', path_to_back, :class => 'button negative', :title => t('general.cancel')}
    </li>"
  end
  
  def object_messages(obj = nil)
    if !obj.nil? && !obj.errors.blank?
      str_msg = '<div class="error">' + obj.errors.full_messages.join('<br/>') + '</div><br/>'
    elsif !flash[:error].blank?
      str_msg = '<div class="error">' + flash[:error] + '</div><br/>'
    elsif !flash[:notice].blank?
      str_msg = '<div class="notice">' + flash[:notice] + '</div><br/>'
    elsif !flash[:success].blank?
      str_msg = '<div class="success">' + flash[:success] + '</div><br/>'
    else
      str_msg = ''
    end
    flash[:error] = ''
    flash[:notice] = ''
    flash[:success] = ''
    return str_msg
  end

  def get_order(field_name)
    order_hash = {:order => field_name}
    if (@query_order == field_name)
      order_hash[:direction] = (@direction == 'asc' ? 'desc' : 'asc')
    else
      order_hash[:direction] = 'asc'
    end
    return order_hash
  end
  
end
