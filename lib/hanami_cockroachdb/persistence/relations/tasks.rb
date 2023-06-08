module HanamiCockroachdb
    module Persistence
      module Relations
        class Tasks < ROM::Relation[:sql]
          schema(:tasks, infer: true)
        end
      end
    end
end
  