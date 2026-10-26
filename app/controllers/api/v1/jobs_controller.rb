module Api
  module V1
    class JobsController < ApplicationController
      before_action :set_job, only: [:show, :update, :destroy]

      # GET /api/v1/jobs?name=React&place=Remote ИЛИ /api/v1/companies/:company_id/jobs
      def index
        jobs = Job.all
        jobs = jobs.where(company_id: params[:company_id]) if params[:company_id]
        jobs = jobs.where("name ILIKE ?", "%#{params[:name]}%") if params[:name]
        jobs = jobs.where("place ILIKE ?", "%#{params[:place]}%") if params[:place]
        render json: jobs, each_serializer: JobSerializer
      end

      # GET /api/v1/jobs/:id
      def show
        render json: @job, serializer: JobSerializer
      end

      # POST /api/v1/jobs
      def create
        job = Job.new(job_params)
        if job.save
          render json: job, serializer: JobSerializer, status: :created
        else
          render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/jobs/:id
      def update
        if @job.update(job_params)
          render json: @job, serializer: JobSerializer
        else
          render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/jobs/:id
      def destroy
        @job.destroy
        render json: { message: 'Job deleted' }, status: :ok
      end

      # GET /api/v1/jobs/:job_id/geeks
      def geeks
        job = Job.find(params[:job_id])
        render json: job.geeks, each_serializer: GeekSerializer
      end

      private

      def set_job
        @job = Job.find(params[:id])
      end

      def job_params
        params.require(:job).permit(:name, :place, :company_id)
      end
    end
  end
end