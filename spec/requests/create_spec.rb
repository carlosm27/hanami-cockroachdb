

RSpec.describe "POST /tasks", type: [:request, :database] do
    let(:request_headers) do
      {"HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json"}
    end
  
    context "given valid params" do
      let(:params) do
        {task: {task: "Buy the groceries", completed: "true"}}
      end
  
      it "creates a task" do
        post "/tasks", params.to_json, request_headers
  
        expect(last_response).to be_created
      end
    end
  
    context "given invalid params" do
      let(:params) do
        {task: {task: nil}}
      end
  
      it "returns 422 unprocessable" do
        post "/tasks", params.to_json, request_headers
  
        expect(last_response).to be_unprocessable
      end
    end
  end
  