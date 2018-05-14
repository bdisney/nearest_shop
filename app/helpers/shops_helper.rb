module ShopsHelper
  def edit_or_update_action?
    action_name == 'edit' || 'update'
  end
end