require "securerandom"

module Flowchart
  class Create < Service
    def initialize(params, user)
      @title = params.fetch(:title, nil)
      @user = user
    end

    def call
      flow = Flow.create(
        user_id: @user.id,
        identifier: random_identifier,
        title: @title,
        descriptor: {},
      )
      ok!(flow)
    end

    private

    def random_identifier
      identifier = SecureRandom.alphanumeric(6)
      random_identifier unless Flow.where(identifier: identifier).count.zero?
      identifier
    end
  end
end