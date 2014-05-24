# users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      orders_path()
    end

    # def after_update_path_for(resource)
    #   new_pin_path()
    # end
end