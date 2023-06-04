RSpec.describe "GET /tasks", type: :request do
    it "is successful" do
      get "/tasks"

      expect(last_response).to be_successful
      expect(last_response.content_type).to eq("application/json; charset=utf-8")

      response_body = JSON.parse(last_response.body)  
      # Find me in `config/routes.rb`
      
      expect(response_body).to eq({"task"=>"Writing a new article","completed" =>"false"})
    end
  end