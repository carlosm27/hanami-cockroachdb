# frozen_string_literal: true
require "rom"
module HanamiCockroachdb
  module Actions
    module Tasks
      class Show < HanamiCockroachdb::Action
        include Deps["persistence.rom"]

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          
          task = rom.relations[:tasks].by_pk(
            request.params[:id]
          ).one
          response.format = :json

          if task
           
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
