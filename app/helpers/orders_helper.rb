module OrdersHelper

  def link_to_delivery_note(order)
    order.delivery_note.blank? ? link_to(image_tag('delivery_note.png', :alt => t('orders.delivery_note.new')), new_order_delivery_note_path(order), :title => t('orders.delivery_note.new')) : link_to(image_tag('delivery_note.png', :alt => t('orders.delivery_note.edit')), edit_delivery_note_path(order.delivery_note), :title => t('orders.delivery_note.edit'))
  end

  def link_to_invoice(order)
    order.invoice.blank? ? link_to(image_tag('cash_register.png', :alt => t('orders.invoice.new')), new_order_invoice_path(order), :title => t('orders.invoice.new')) : link_to(image_tag('cash_register.png', :alt => t('orders.invoice.edit')), edit_invoice_path(order.invoice), :title => t('orders.invoice.edit'))
  end

  def order_form_buttons(path_to_back, order)
    "<li class=\"form-buttons\">
    <button type=\"submit\" class=\"positive\">
      #{image_tag 'icons/tick.png', :alt => t('general.ok'), :title => t('general.ok')}<span>#{t'general.ok'}</span>
    </button>
      #{link_to image_tag('icons/cross.png', :alt => t('general.cancel')) + 'Volver', path_to_back, :class => 'button negative', :title => t('general.cancel')}
      #{order.delivery_note.blank? ? link_to(image_tag('delivery_note.png', :alt => t('orders.delivery_note.new')) + t('activerecord.models.delivery_note'), new_order_delivery_note_path(order), :title => t('orders.delivery_note.new'), :class => 'button') : link_to(image_tag('delivery_note.png', :alt => t('orders.delivery_note.edit')) + t('activerecord.models.delivery_note'), edit_delivery_note_path(order.delivery_note), :title => t('orders.delivery_note.edit'), :class => :button)}
      #{order.invoice.blank? ? link_to(image_tag('cash_register.png', :alt => t('orders.invoice.new')) + t('activerecord.models.invoice'), new_order_invoice_path(order), :title => t('orders.invoice.new'), :class => 'button') : link_to(image_tag('cash_register.png', :alt => t('orders.invoice.edit')) + t('activerecord.models.invoice'), edit_invoice_path(order.invoice), :title => t('orders.invoice.edit'), :class => 'button')}
    </li>"

  end

  def order_state_events(order)
    events = order.aasm_events_for_current_state
    str = ''
    events.each do |event|
      str += event_button(event)
    end

    str
    
  end

  def event_button(event)
    link_to(image_tag("#{event.to_s}.png", :alt => t("orders.events.#{event}.alt")) + t("orders.events.#{event}.button_name"), eval("#{event}_url"), :title => t("orders.events.#{event}.title"), :class => 'button')
  end

end
