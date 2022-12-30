# frozen_string_literal: true

class NavBarComponent < ViewComponent::Base
  def initialize(items:)
    @items = items
  end

end
