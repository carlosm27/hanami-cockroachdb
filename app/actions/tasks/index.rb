# frozen_string_literal: true

module HanamiCockroachdb
  module Actions
    module Tasks
      class Index < HanamiCockroachdb::Action

        def my_task 
          task = {
            "task":"Writing a new article",
            "completed": "false",
          }
          return task
        end

        def handle(*, response)
          task = my_task
          response.format = :json
          response.body = task.to_json
        end
      end
    end
  end
end
