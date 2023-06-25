class SiteController < ApplicationController
  skip_before_action :verify_authenticity_token
  helper_method :redirect_to
  def index
  end

  def product
  end

  def buy_product
    if current_user.money >= 10
      current_user.money -= 10
      current_user.save
      send_file(
        "#{Rails.root}/PasswordGenerator",
        filename: "PasswordGenerator",
        type: "application/octet-stream"
      )
      flash[:success] = "You have successfully purchased the product."
      
    else
      redirect_to :site_purchase, notice: "You don't have enough money to purchase the product."
    end
  end

  def transfer_money
    if user_signed_in?
      email = params.require(:email)
      amount = params.require(:amount)
      
      # check if email matches revworks.thm and amount is integer
      if email.match(/\A([\w+\-].?)+@revworks\.thm\z/) and amount.match(/\A[+-]?\d+\z/)

        # check if amount is negative, because otherwise user transfers negative value
        # which increments his own amount. amount - (-value)
        if amount.to_i < 0
          redirect_to :site_transfer, notice: "You can not transfer negative amount to another user."

        # check if user has the amount to transfer
        elsif amount.to_i > current_user.money
          redirect_to :site_transfer, notice: "You don't have enough money to transfer."
        else

          # check if user exists
          if User.find_by_email(email).nil?
            redirect_to :site_transfer, notice: "User doesn't exist."
          else
            # check if user isn't himself
            if User.find_by_email(email) == current_user
              redirect_to :site_transfer, notice: "Silly, You can't transfer money to yourself."
            else
              # check if it's only to/from the same one user
              user = User.find_by(email: email)
              if user.related_users.count < 1 and !user.related_users.map(&:email).include? current_user.email
                # Add the new relationship
                UserRelationship.create(user_id: user.id, related_user_id: current_user.id)

                # transfer money
                current_user.money -= amount.to_i
                current_user.save
                user.money += amount.to_i
                user.save
                redirect_to :site_transfer, notice: "You have successfully transferred money to #{email}."

              elsif user.related_users.map(&:email).include? current_user.email
                # transfer money
                current_user.money -= amount.to_i
                current_user.save
                user.money += amount.to_i
                user.save
                redirect_to :site_transfer, notice: "You have successfully transferred money to #{email}."

              else
                redirect_to :site_transfer, notice: "User can only send/recieve from one user right now."
              end
            end
          end
        end
      else
        flash[:danger] = "Invalid email domain, please use revworks.thm"
        redirect_to :site_transfer
      end
    
    else
      redirect_to new_user_session_path
    end
  end
end
