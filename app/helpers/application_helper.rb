# frozen_string_literal: true

# nodoc
module ApplicationHelper

  def flash_alert_class(type)
    if type == 'notice'
      'success'
    elsif type == 'alert'
      'danger'
    else
      type
    end
  end
end
