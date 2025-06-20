require 'rails_helper'

RSpec.describe "Api::Tasks", type: :request do
  let(:response_body) { JSON.parse(response.body) }

  describe "GET /api/tasks" do
    it "returns all tasks" do
      create_list(:task, 3)

      get "/api/tasks"

      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(3)
    end
  end

  describe "GET /api/tasks/:id" do
    context "when the task exists" do
      it "returns the task" do
        task = create(:task)

        get "/api/tasks/#{task.id}"

        expect(response).to have_http_status(:ok)
        expect(response_body["id"]).to eq(task.id)
      end
    end

    context "when the task does not exist" do
      it "returns a not found error" do
        get "/api/tasks/999"

        expect(response).to have_http_status(:not_found)
        expect(response_body["error"]).to eq("Task not found")
      end
    end
  end

  describe "POST /api/tasks" do
    context "with valid parameters" do
      let(:valid_params) { { task: { title: "New Task", description: "Task description" } } }

      it "creates a new task" do
        expect {
          post "/api/tasks", params: valid_params
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response_body["title"]).to eq("New Task")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { task: { title: nil, description: "Task description" } } }

      it "does not create a new task and returns errors" do
        expect {
          post "/api/tasks", params: invalid_params
        }.not_to change(Task, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body["errors"]).to include("Title can't be blank")
      end
    end
  end

  describe "PATCH /api/tasks/:id" do
    let(:task) { create(:task) }

    context "when the task exists" do
      context "with valid parameters" do
        let(:valid_params) { { task: { title: "Updated Task" } } }

        it "updates the task" do
          patch "/api/tasks/#{task.id}", params: valid_params

          expect(response).to have_http_status(:ok)
          expect(response_body["title"]).to eq("Updated Task")
          expect(task.reload.title).to eq("Updated Task")
        end
      end

      context "with invalid parameters" do
        let(:invalid_params) { { task: { title: nil } } }

        it "does not update the task and returns errors" do
          patch "/api/tasks/#{task.id}", params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body["errors"]).to include("Title can't be blank")
          expect(task.reload.title).not_to be_nil
        end
      end
    end

    context "when the task does not exist" do
      it "returns a not found error" do
        patch "/api/tasks/999", params: { task: { title: "Updated Task" } }

        expect(response).to have_http_status(:not_found)
        expect(response_body["error"]).to eq("Task not found")
      end
    end
  end

  describe "DELETE /api/tasks/:id" do
    context "when the task exists" do
      it "deletes the task" do
        task = create(:task)

        expect {
          delete "/api/tasks/#{task.id}"
        }.to change(Task, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the task does not exist" do
      it "returns a not found error" do
        delete "/api/tasks/999"

        expect(response).to have_http_status(:not_found)
        expect(response_body["error"]).to eq("Task not found")
      end
    end
  end
end
