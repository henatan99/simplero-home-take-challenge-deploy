# frozen_string_literal: true

class MenuBarComponent < ViewComponent::Base
  def initialize(items:)
    @items = items
  end

end
