# spec/requests/show_spec.rb

RSpec.describe "DELETE /tasks/:id", type: [:request, :database] do
    let(:task) { app["persistence.rom"].relations[:tasks] }
    
  
    context "when a task matches the given id" do
      let!(:id) do
        task.insert(task: "Publish a new article", completed: "false")
      end
  
      it "deletes the task" do
        delete "/tasks/#{id}"
  
        expect(last_response).to be_successful
        
        
  
        response_body = last_response.body
  
        expect(response_body).to eq(
          "Task Deleted"
        )
      end
    end
  
    context "when no task matches the given id" do
      it "returns not found" do
        delete "/tasks/#{task.max(:id).to_i + 1}"
  
        expect(last_response).to be_not_found
        
  
        response_body = JSON.parse(last_response.body)
  
        expect(response_body).to eq(
          "error" => "not_found"
        )
      end
    end
  end
  