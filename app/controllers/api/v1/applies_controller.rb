module Api
  module V1
    class AppliesController < ApplicationController
      before_action :set_apply, only: [:show, :update, :destroy, :read_apply, :invite_geek]

      # GET /api/v1/applies?read=true&invited=false
      # GET /api/v1/jobs/:job_id/applies
      # GET /api/v1/geeks/:geek_id/applies
      def index
        applies = Apply.all
        applies = applies.where(read: params[:read]) if params[:read].present?
        applies = applies.where(invited: params[:invited]) if params[:invited].present?
        applies = applies.where(job_id: params[:job_id]) if params[:job_id]
        applies = applies.where(geek_id: params[:geek_id]) if params[:geek_id]
        render json: applies, each_serializer: ApplySerializer
      end

      # GET /api/v1/applies/:id
      def show
        render json: @apply, serializer: ApplySerializer
      end

      # POST /api/v1/applies
      def create
        apply = Apply.new(apply_params)
        if apply.save
          render json: apply, serializer: ApplySerializer, status: :created
        else
          render json: { errors: apply.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/applies/:id
      def update
        if @apply.update(apply_params)
          render json: @apply, serializer: ApplySerializer
        else
          render json: { errors: @apply.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/applies/:id
      def destroy
        @apply.destroy
        render json: { message: 'Apply deleted' }, status: :ok
      end

      # PUT /api/v1/applies/:id/read
      def read_apply
        @apply.update(read: true)
        render json: @apply, serializer: ApplySerializer
      end

      # PUT /api/v1/applies/:id/invite
      def invite_geek
        @apply.update(invited: true)
        render json: @apply, serializer: ApplySerializer
      end

      private

      def set_apply
        @apply = Apply.find(params[:id])
      end

      def apply_params
        params.require(:apply).permit(:job_id, :geek_id, :read, :invited)
      end
    end
  end
end