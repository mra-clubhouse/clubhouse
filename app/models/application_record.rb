class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  if Rails.env.production?
    connects_to database: { writing: :primary, reading: :primary_replica }
  else
    connects_to database: { writing: Rails.env.to_sym, reading: Rails.env.to_sym }
  end
end
