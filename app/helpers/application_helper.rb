module ApplicationHelper
  def current_page_name
    I18n.t("#{controller_name}.#{action_name}.page_name")
  end
end
