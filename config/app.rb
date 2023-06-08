# frozen_string_literal: true

require "hanami"

module HanamiCockroachdb
  class App < Hanami::App
    config.middleware.use :body_parser, :json
  end
end
