class UsersController < ApplicationController
  def my_friends
    @tracked_friends = current_user.friends
  end

  def my_portfolio
    @tracked_stocks = current_user.company_stocks
  end

  def search 
    if params[:friend].present?
      all_matches    = User.friend_lookup(params[:friend])
      friend_matches = all_matches.reject { |x| x.id == current_user.id }

      @friends = friend_matches

      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end 
      else 
        respond_to do |format|
          flash.now[:alert] = "The name #{params[:friend]} was not found"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend's name"
        format.js { render partial: 'users/friend_result' }
      end
    end 
  end  
end
