# frozen_string_literal: true

module HanamiCockroachdb
  module Actions
    module Tasks
      class Create < HanamiCockroachdb::Action
        include Deps["persistence.rom"]

        params do
          required(:task).hash do
            required(:task).filled(:string)
            required(:completed).filled(:string)
          end
        end 


        def handle(request, response)
          if request.params.valid?
            task = rom.relations[:tasks].changeset(:create, request.params[:task]).commit
            
            response.status = 201
            response.body = task.to_json
          else
            response.status = 422
            response.format = :json
            response.body = request.params.errors.to_json
          end   
        end
      end
    end
  end
end
