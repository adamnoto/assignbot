require 'spec_helper'

class User
  include Assignbot
  attr_accessor :name, :age, :id

  assigner do
    name from: :name
    age from: :age
    id from: :id
  end
end

describe Assignbot do
  it 'has a version number' do
    expect(Assignbot::VERSION).not_to be nil
  end

  let(:params) do
    {
      name: "Adam Pahlevi",
      age: 23,
      id: "934-2311"
    }
  end

  context "version 0.1.0" do
    it "can define dsl" do
      expect do
        class UserRedefine
          include Assignbot
          assigner do
            name from: :name
            age from: :age
            id from: :id
          end
        end
      end.to_not raise_error

      assignable = Assignbot::Core.get_assignable(User)
      assigner = assignable.get_assigner :default
      expect(assignable.class).to eq(Assignbot::Assignable)
      expect(assigner.class).to eq(Assignbot::Assigner)

      # test it has all the variables
      expect(assigner.get_variable(:name)).to_not be_nil
      expect(assigner.get_variable(:age)).to_not be_nil
      expect(assigner.get_variable(:id)).to_not be_nil

      # test it is nil if asking for un-defined variable
      expect(assigner.get_variable(:not_exist)).to be_nil
    end

    context "User" do
      let(:user) { User.new }
      before do
        expect(user.id).to be_nil
        expect(user.name).to be_nil
        expect(user.age).to be_nil
      end

      context ".assign" do
        it "can get assigned by using hash" do
          user.assign(params)
          expect(user.id).to eq(params[:id])
          expect(user.id).to eq("934-2311")
          expect(user.age).to eq(params[:age])
          expect(user.age).to eq(23)
          expect(user.name).to eq(params[:name])
          expect(user.name).to eq("Adam Pahlevi")
        end # it
      end # .assign
      
      context ".assign_default" do
        it "can get assigned by using hash" do
          user.assign_default(params)
          expect(user.id).to eq(params[:id])
          expect(user.id).to eq("934-2311")
          expect(user.age).to eq(params[:age])
          expect(user.age).to eq(23)
          expect(user.name).to eq(params[:name])
          expect(user.name).to eq("Adam Pahlevi")
        end
      end
    end # User
  end # context version 0.1.0
end
