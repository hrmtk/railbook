# frozen_string_literal: true

module FriendDecorator
  def email_link(body = nil, &block)
    if block_given?
      link_to("mailto:#{email}", &block)
    else
      link_to(body, "mailto:#{email}")
    end
  end
end
