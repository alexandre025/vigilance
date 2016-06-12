class OrganizationsController < ApplicationController
  load_and_authorize_resource :organization, find_by: :slug

  before_action :set_organization, only: [:invit, :send_invit]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.by_assignments(current_user)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.assignments << Assignment.new({user: current_user, organization: @organization, is_admin: true, is_active: true})

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invit

  end

  def send_invit
    if user = User.find_by_email(params[:email])
      if user.organizations.include? @organization
        render json: '', status: 200, notice: 'Already in'
      else
        user.new_token!
        assignment = Assignment.new(organization: @organization, user: user, is_active: false, is_admin: false)
        assignment.save!
        assignment.new_token!
        OrganizationMailer.send_invit(assignment).deliver_now
        render json: '', status: 200, notice: 'Invitation sent'
      end
    else
      render json: '', status: 404, alert: 'User not found'
    end
  end

  def join
    byebug
    if assignment = Assignment.find_by(assignment_token: params[:assignment_token])
      assignment.activate!
      redirect_to organization_path(assignment.organization), notice: "You succefully joined #{assignment.organization.name}"
    else
      redirect_to organizations_path, alert: 'Error'
    end
  end

  private
  def set_organization
    @organization = Organization.find_by_slug(params[:organization_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:name)
  end
end
