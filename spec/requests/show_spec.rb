# spec/requests/show_spec.rb

RSpec.describe "GET /tasks/:id", type: [:request, :database] do
    let(:task) { app["persistence.rom"].relations[:tasks] }
    
  
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
  
    context "when no task matches the given id" do
      it "returns not found" do
        get "/tasks/#{task.max(:id).to_i + 1}"
  
        expect(last_response).to be_not_found
        expect(last_response.content_type).to eq("application/json; charset=utf-8")
  
        response_body = JSON.parse(last_response.body)
  
        expect(response_body).to eq(
          "error" => "not_found"
        )
      end
    end
  end
  