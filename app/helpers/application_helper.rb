module ApplicationHelper
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    errors = Array(instance.error_message).join(',')
    %(<div class="error">#{html_tag}<img src="/assets/alert.png" title="#{errors}" /></div><div class="error">#{errors}</div>).html_safe
  end
end
