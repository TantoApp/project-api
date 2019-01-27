class Api::V1::ProjectsController < ApplicationController
  def index
    run Project::Index
    render json: result["model"]
  end

  def show
    run Project::Show
    render json: result["model"]
  end

  def create
    run Project::Create do |result|
      if (errors = result["result.contract.default"].try(:errors)).present?
        render json: errors, status: :unprocessable_entity
      else
        render json: result['model'], status: :created, location: @api_v1_project
      end
    end
  end

  def update
    run Project::Update do |result|
      if (errors = result["result.contract.default"].try(:errors)).present?
        render json: errors, status: :unprocessable_entity
      else
        render json: result['model'], status: :created, location: @api_v1_project
      end
    end
  end

  def destroy
    run Project::Delete
  end
end
