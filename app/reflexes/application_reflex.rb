# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  include MultiDatabase

  delegate :current_user, to: :connection
end
