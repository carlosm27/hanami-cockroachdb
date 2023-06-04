# frozen_string_literal: true

module HanamiCockroachdb
  class Routes < Hanami::Routes
    root { "Hello from Hanami" }
    get "/tasks", to: "tasks.index"
  end
end
