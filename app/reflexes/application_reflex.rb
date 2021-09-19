# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection
  # delegate :render, :render_to_string, to: ApplicationController
end
