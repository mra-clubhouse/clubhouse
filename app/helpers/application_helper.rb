module ApplicationHelper
  include Pagy::Frontend

  def flash_types
    [
      { type: "notice", css_class: "is-info", icon: "fas fa-info-circle" },
      { type: "alert", css_class: "is-danger", icon: "fas fa-exclamation-triangle" },
      { type: "success", css_class: "is-success", icon: "far fa-check-circle" },
    ]
  end

  def submit_button
    button_tag type: "submit", name: "commit", class: "button is-success" do
      tag.span class: "icon" do
        tag.i class: "fas fa-paper-plane"
      end
      tag.span "Submit"
    end
  end
end
