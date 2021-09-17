module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_user_via_warden
    end

    private

    # Returns a user object, or nil
    def current_user_via_warden
      env["warden"].user
    end
  end
end
