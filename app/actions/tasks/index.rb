# frozen_string_literal: true

module HanamiCockroachdb
  module Actions
    module Tasks
      class Index < HanamiCockroachdb::Action
        include Deps["persistence.rom"]

       

        def handle(*, response)
          task = rom.relations[:tasks]
            .select(:id, :task, :completed)
            .to_a
          response.format = :json
          response.body = task.to_json
        end
      end
    end
  end
end
