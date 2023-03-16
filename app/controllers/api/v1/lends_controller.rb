class Api::V1::LendsController < ApplicationController
    def index
        @lends = Lend.includes([:staff,:asset]).all

        render json: @lends.as_json(except: [:staff_id, :asset_id, :created_at, :updated_at], include: { staff: { only: [:id, :name, :department]}, asset: {only: [:id, :name, :asset_type]}})
    end

    def show
        @lends = Lend.includes([:staff,:asset]).find(params[:id])
        render json: @lends.as_json(except: [:staff_id, :asset_id], include: { staff: { only: [:id, :name, :department]}, asset: {only: [:id, :name, :asset_type]}})
    
    end
  
    def create
      @lend = Lend.new(lend_params)
  
      if @lend.save
        render json: @lend, status: :created
      else
        render json: @lend.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @lend = Lend.find(params[:id])
  
      if @lend.update(lend_params)
        render json: @lend
      else
        render json: @lend.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @lend = Lend.find(params[:id])
      @lend.destroy
    end

    private

    def lend_params
      params.require(:lend).permit(:staff_id, :asset_id, :lend_status, :lended_at)
    end
end