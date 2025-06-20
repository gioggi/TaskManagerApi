require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:task)).to be_valid
    end
  end

  describe 'validations' do
    it 'is valid with a title, description, and completed status' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'is invalid without a title' do
      task = build(:task, title: nil)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'generates different data with Faker' do
      task1 = build(:task)
      task2 = build(:task)

      # With our fixed Faker seed, the data should still be different
      # between multiple factory calls
      expect(task1.title).not_to eq(task2.title)
      expect(task1.description).not_to eq(task2.description)
    end
  end
end
