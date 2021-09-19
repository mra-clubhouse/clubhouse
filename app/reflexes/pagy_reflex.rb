# frozen_string_literal: true

class PagyReflex < ApplicationReflex
  def page
    @page = element.dataset[:page].to_i
  end
end
