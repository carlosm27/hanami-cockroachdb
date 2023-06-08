# frozen_string_literal: true

module HanamiCockroachdb
  class Routes < Hanami::Routes
    root { "Hello from Hanami" }
    get "/tasks", to: "tasks.index"
    post "/tasks", to: "tasks.create"
    get "/tasks/:id", to: "tasks.show"
    patch "/tasks/:id", to: "tasks.update"
    delete "/tasks/:id", to: "tasks.destroy"
  end
end
