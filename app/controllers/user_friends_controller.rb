class UserFriendsController < ApplicationController
   def create 
    # Add friend to list of tracked friends (create a list item)
    friendship     = Friendship.create(user_id: params[:user], friend_id: params[:friend])
    @friend        = User.find(friendship.friend_id)
    flash[:notice] = "Following #{full_name}"

    redirect_to my_friends_path
  end 

  def destroy 
    # Remove friend from list of tracked friends (remove list item)
    Friendship.find_by(user_id: current_user.id, friend_id: params[:id]).destroy

    @friend        = User.find(params[:id])
    flash[:notice] = "No longer following #{full_name}"

    redirect_to my_friends_path
  end

  def full_name 
    name = "#{@friend.first_name} #{@friend.last_name}"
    name.strip! || name
  end 
end
