

RSpec.describe "PATCH /tasks/:id", type: [:request, :database] do
    let(:task) { app["persistence.rom"].relations[:tasks] }
    let(:request_headers) do
      {"HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json"}
    end
  
    context "when a task matches the given id" do
        let!(:id) do
          task.insert(task: "Publish a new article", completed: "false")
        end
    
        it "renders the task" do
          get "/tasks/#{id}"
    
          expect(last_response).to be_successful
          expect(last_response.content_type).to eq("application/json; charset=utf-8")
    
          response_body = JSON.parse(last_response.body)
    
          expect(response_body).to eq(
            "id" => id, "task" => "Publish a new article", "completed" => "false"
          )
        end
      end

    context "given valid params" do
      let!(:id) do
        task.insert(task: "Publish a new article", completed: "false")
      end
      it "should update the task" do
        patch "/tasks/#{id}", params: { task: "New Title" }
  
        expect(response).to be_successful
        expect(task.reload.title).to eq("New Title")
      end
    end  
  
    context "given invalid params" do
      let(:params) do
        {task: {task: nil}}
      end
  
      it "returns 422 unprocessable" do
        patch "/tasks/#{id}", params.to_json, request_headers
  
        expect(last_response).to be_unprocessable
      end
    end

    context "when no task matches the given id" do
        it "returns not found" do
          patch "/tasks/#{task.max(:id).to_i + 1}"
    
          expect(last_response).to be_not_found
          expect(last_response.content_type).to eq("application/json; charset=utf-8")
    
          response_body = JSON.parse(last_response.body)
    
          expect(response_body).to eq(
            "error" => "not_found"
          )
        end
    end
end
  