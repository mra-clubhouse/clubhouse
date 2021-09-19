# frozen_string_literal: true

class SearchReflex < ApplicationReflex
  def clear
    params[:q] = {}
  end
end
