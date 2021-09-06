class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_bad_message
    def create
        lease = Lease.create!(leases_params)
        render json: lease, status: :created
    end
    def destroy
        lease = Lease.find_by(id: params[:id])
        lease.destroy
        head :no_content
    end
    private
    def leases_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
    def record_invalid_bad_message(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
