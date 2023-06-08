# frozen_string_literal: true

module HanamiCockroachdb
  module Actions
    module Tasks
      class Destroy < HanamiCockroachdb::Action
        include Deps["persistence.rom"]
        params do
          required(:id).value(:integer)
          
        end 

        def handle(request, response)
          task = rom.relations[:tasks].by_pk(
            request.params[:id]
          ).one
          
          if task
            task = rom.relations[:tasks].by_pk(request.params[:id]).command(:delete)
            task.call
            response.body = "Task Deleted"
            
          else
            response.status = 404
            response.body = {error:"not_found"}.to_json
            
          end  
        end
      end
    end
  end
end
