# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Tasks API', type: :request do
  path '/api/tasks' do
    get('list tasks') do
      tags 'Tasks'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
    post('create task') do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string }
        },
        required: [ 'title' ]
      }
      response(201, 'created') do
        let(:task) { { title: 'Test', description: 'Test desc' } }
        run_test!
      end
    end
  end

  path '/api/tasks/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('show task') do
      tags 'Tasks'
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { Task.create(title: 'Test').id }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    patch('update task') do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string }
        }
      }
      response(200, 'updated') do
        let(:id) { Task.create(title: 'Test').id }
        let(:task) { { title: 'Updated' } }
        run_test!
      end
    end
    delete('delete task') do
      tags 'Tasks'
      response(204, 'no content') do
        let(:id) { Task.create(title: 'Test').id }
        run_test!
      end
    end
  end
end

