module ApplicationHelper
  def materialize_toast(flash_type)
    flash_type =
      case flash_type.to_sym
      when :success then 'green rounded'
      when :error then 'red rounded'
      when :alert then 'orange rounded'
      when :notice then 'blue rounded'
      else flash_type.to_s
      end
    flash_type
  end
end
