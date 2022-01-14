class UserFriendsController < ApplicationController
   def create 
    # Add friend to list of tracked friends (create a list item)
    friendship     = current_user.friendships.create(friend_id: params[:friend])
    
    @friend        = User.find(friendship.friend_id)
    flash[:notice] = "Following #{full_name}"

    redirect_to my_friends_path
  end 

  def destroy 
    # Remove friend from list of tracked friends (remove list item)
    current_user.friendships.where(friend_id: params[:id]).first.destroy

    @friend        = User.find(params[:id])
    flash[:notice] = "No longer following #{full_name}"

    redirect_to my_friends_path
  end

  def full_name 
    return "#{@friend.first_name} #{@friend.last_name}".strip if @friend.first_name || @friend.last_name
    "Anonymous"
  end 
end
