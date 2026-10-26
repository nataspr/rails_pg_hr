module Api
  module V1
    class GeeksController < ApplicationController
      before_action :set_geek, only: [:show, :update, :destroy, :update_resume]

      # GET /api/v1/geeks?name=Mike&stack=Ruby
      def index
        geeks = Geek.all
        geeks = geeks.where("name ILIKE ?", "%#{params[:name]}%") if params[:name]
        geeks = geeks.where("stack ILIKE ?", "%#{params[:stack]}%") if params[:stack]
        render json: geeks, each_serializer: GeekSerializer
      end

      # GET /api/v1/geeks/:id
      def show
        render json: @geek, serializer: GeekSerializer
      end

      # POST /api/v1/geeks
      def create
        geek = Geek.new(geek_params)
        if geek.save
          render json: geek, serializer: GeekSerializer, status: :created
        else
          render json: { errors: geek.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/geeks/:id
      def update
        if @geek.update(geek_params)
          render json: @geek, serializer: GeekSerializer
        else
          render json: { errors: @geek.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/geeks/:id/resume
      def update_resume
        if @geek.update(resume: params[:resume])
          render json: @geek, serializer: GeekSerializer
        else
          render json: { errors: @geek.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/geeks/:id
      def destroy
        @geek.destroy
        render json: { message: 'Geek deleted' }, status: :ok
      end

      # GET /api/v1/geeks/:geek_id/read_applies
      def read_applies
        geek = Geek.find(params[:geek_id])
        render json: geek.applies.where(read: true), each_serializer: ApplySerializer
      end

      # GET /api/v1/geeks/:geek_id/invited_applies
      def invited_applies
        geek = Geek.find(params[:geek_id])
        render json: geek.applies.where(invited: true), each_serializer: ApplySerializer
      end

      private

      def set_geek
        @geek = Geek.find(params[:id])
      end

      def geek_params
        params.require(:geek).permit(:name, :stack, :resume)
      end
    end
  end
end