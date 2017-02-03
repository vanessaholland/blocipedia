class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "Upgrade Account - #{current_user.email}",
      amount: 1500
    }
   end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    token = params[:stripeToken]
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: token
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 1500,
      description: "Upgrade Account - #{current_user.email}",
      currency: 'usd'
    )
    if charge.present?
      @charge = Charge.new
      @charge.user = current_user
      @charge.amount = charge.amount
      @charge.successful = true

      if @charge.save
        current_user.update_attributes(role: 'premium')
        if current_user.role == 'premium'
          flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
          redirect_to manage_account_path(current_user) # or wherever
        else
          flash[:notice] = 'Sorry, something went wrong. Please try again later'
          redirect_to manage_account_path(current_user)
        end
      else
        flash[:notice] = 'Sorry, something went wrong. Please try again later'
        redirect_to manage_account_path(current_user)
      end
    end
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to manage_account_path
   end

  def downgrade
  current_user.update_attributes(role: 'standard')
  if current_user.standard?
    flash[:notice] = 'Ya basic'
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    redirect_to manage_account_path(current_user)
  else
    flash[:notice] = 'Sorry, something went wrong. Please try again later'
    redirect_to manage_account_path(current_user)
  end
 end
end
