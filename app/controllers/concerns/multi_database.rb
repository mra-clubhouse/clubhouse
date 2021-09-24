# frozen_string_literal: true

module MultiDatabase
  extend ActiveSupport::Concern

  private

  def using_global_primary
    ActiveRecord::Base.connected_to(role: :writing) { yield }
  end

  def using_regional_replica
    ActiveRecord::Base.connected_to(role: :reading) { yield }
  end
end
