class ContentsController < ApplicationController
  load_and_authorize_resource :organization, find_by: :slug
  load_and_authorize_resource :content, through: :organization

  before_action :set_properties, only: [:to_read, :like]

  # GET /contents
  # GET /contents.json
  def index
    @contents = Content.by_organization(@organization)
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)

    @content.organization = @organization
    @content.user = current_user

    respond_to do |format|
      if @content.save
        format.html { redirect_to organization_content_path(@organization, @content), notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to organization_content_path(@organization, @content), notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to organization_contents_url(@organization), notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def to_read
    if ContentsSaved.is_saved_to_read?(@content, current_user)
      ContentsSaved.destroy(ContentsSaved.find_by(content: @content, user: current_user, relation: :to_read))
    else
      ContentsSaved.create(content: @content, user: current_user, relation: :to_read)
    end
    render json: '', status: 200
  end

  def like
    if ContentsSaved.is_liked?(@content, current_user)
      ContentsSaved.destroy(ContentsSaved.find_by(content: @content, user: current_user, relation: :liked))
    else
      ContentsSaved.create(content: @content, user: current_user, relation: :liked)
    end
    render json: '', status: 200
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit(:title, :description, :comment, :source, :importance, tag_ids: [])
  end

  def set_properties
    @organization = Organization.find_by_slug(params[:organization_id])
    @content = Content.find(params[:content_id])
  end
end
