module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: [:show, :update, :destroy, :mark_deleted]

      # GET /api/v1/companies?name=MoGo&location=London
      def index
        companies = Company.all
        companies = companies.where("name ILIKE ?", "%#{params[:name]}%") if params[:name]
        companies = companies.where("location ILIKE ?", "%#{params[:location]}%") if params[:location]
        render json: companies, each_serializer: CompanySerializer
      end

      # GET /api/v1/companies/:id
      def show
        render json: @company, serializer: CompanySerializer
      end

      # POST /api/v1/companies
      def create
        company = Company.new(company_params)
        if company.save
          render json: company, serializer: CompanySerializer, status: :created
        else
          render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/companies/:id
      def update
        if @company.update(company_params)
          render json: @company, serializer: CompanySerializer
        else
          render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/companies/:id
      def destroy
        @company.destroy
        render json: { message: 'Company deleted' }, status: :ok
      end

      # GET /api/v1/companies/:company_id/geeks
      def geeks
        company = Company.find(params[:company_id])
        render json: company.geeks, each_serializer: GeekSerializer
      end

      # PUT /api/v1/companies/:id/mark_deleted (Глава 7)
      def mark_deleted
        @company.delete_company
        render json: { status: 'success', code: 200, deleted_company: @company }, status: :ok
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(:name, :location)
      end
    end
  end
end