

RSpec.describe "PATCH /tasks/:id", type: [:request, :database] do
    let(:task) { app["persistence.rom"].relations[:tasks] }
    let!(:id) do
      task.insert(task: "Publish a new article", completed: "false")
    end
  
    context "when a task matches the given id" do
        
    
        it "renders the task" do
          patch "/tasks/#{id}", {"task": {"task":"Publish a new article", "completed":"false"}}.to_json, "CONTENT_TYPE" => "application/json"
    
          expect(last_response).to be_successful
          expect(last_response.content_type).to eq("application/json; charset=utf-8")
    
          response_body = JSON.parse(last_response.body)
    
          expect(response_body).to eq(
            "id" => id, "task" => "Publish a new article", "completed" => "false"
          )
        end
      end

    context "given valid params" do
      
      it "should update the task" do
        patch "/tasks/#{id}", {"task": {"task":"Update task", "completed":"true"}}.to_json, "CONTENT_TYPE" => "application/json"
  
        expect(last_response).to be_successful
        updated_task = task.by_pk(id).one

        expect(updated_task[:task]).to eq("Update task")
        expect(updated_task[:completed]).to eq("true")
      end
    end
    
    context "given invalid params" do
     
  
      it "returns 422 unprocessable" do
        patch "/tasks/#{id}", {task: {task: nil}}.to_json, "CONTENT_TYPE" => "application/json"
  
        expect(last_response).to be_unprocessable
      end
    end

    context "when no task matches the given id" do
      it "returns not found" do
        patch "/tasks/#{task.max(:id).to_i + 1}", {"task": {"task":"Update task", "completed":"true"}}.to_json, "CONTENT_TYPE" => "application/json"
  
        expect(last_response).to be_not_found
  
        response_body = JSON.parse(last_response.body)
  
        expect(response_body).to eq(
          "error" => "not_found"
        )
      end
    end
end
  