# frozen_string_literal: true

class FormComponent < ViewComponent::Base
  def initialize(object:)
    @object = object
  end

end
