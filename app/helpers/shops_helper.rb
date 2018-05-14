module ShopsHelper
  def edit_or_update_action?
    action_name == 'edit' || action_name == 'update'
  end
end
