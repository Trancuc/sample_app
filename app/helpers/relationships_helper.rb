module RelationshipsHelper
  def create_relationship
    current_user.active_relationships.build
  end

  def find_relationship
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
