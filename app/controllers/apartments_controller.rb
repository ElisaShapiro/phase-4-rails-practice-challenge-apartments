class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_bad_message
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_bad_message
    #GET /apartments
    def index
        apartments = Apartment.all
        render json: apartments, except: [:created_at, :updated_at]
    end
    #GET /apartments/:id
    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, except: [:created_at, :updated_at]
    end
    #POST /apartments
    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end
    #PATCH /apartments/:id
    def update
        apartment = Apartment.find_by(id: params[:id])
        apartment.update!(apartment_params)
        render json: apartment
    end
    #DELETE /apartments/:id
    def destroy
        apartment = Apartment.find_by(id: params[:id])
        apartment.destroy
        head :no_content
    end

    private
    def apartment_params
        params.permit(:number)
    end
    def record_not_found_bad_message(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end
    def record_invalid_bad_message(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
