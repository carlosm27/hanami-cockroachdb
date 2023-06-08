# frozen_string_literal: true

module HanamiCockroachdb
  module Actions
    module Tasks
      class Update < HanamiCockroachdb::Action
        include Deps["persistence.rom"]

        params do
          required(:id).value(:integer)
          required(:task).hash do
            required(:task).filled(:string)
            required(:completed).filled(:string)
          end
        end 


        def handle(request, response)
          
          task = rom.relations[:tasks].by_pk(
            request.params[:id]
          ).one
          response.format = :json

          if task
            task = rom.relations[:tasks].by_pk(request.params[:id]).changeset(:update, request.params[:task]).commit
            response.body = task.to_json
            
          else
            response.status = 404
            response.body = {error:"not_found"}.to_json
            
          end  
        end
      end
    end
  end
end
