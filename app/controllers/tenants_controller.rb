class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_bad_message
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_bad_message
    #GET /tenants
    def index
        tenants = Tenant.all
        render json: tenants, except: [:created_at, :updated_at]
    end
    #GET /tenants/:id
    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, except: [:created_at, :updated_at]
    end
    #POST /tenants
    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end
    #PATCH /tenants/:id
    def update
        tenant = Tenant.find_by(id: params[:id])
        tenant.update!(tenant_params)
        render json: tenant
    end
    #DELETE /tenants/:id
    def destroy
        tenant = Tenant.find_by(id: params[:id])
        tenant.destroy
        head :no_content
    end

    private
    def tenant_params
        params.permit(:name, :age)
    end
    def record_not_found_bad_message(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end
    def record_invalid_bad_message(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
