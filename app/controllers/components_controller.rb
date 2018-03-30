class ComponentsController < ApplicationController
  before_action :set_component, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /components
  # GET /components.json
  def index
    @components = Component.all
    authorize! :index, @components
  end

  # GET /components/1
  # GET /components/1.json
  def show
    authorize! :show, @component
  end

  # GET /components/new
  def new
    @component = Component.new
    authorize! :new, @component
  end

  # GET /components/1/edit
  def edit
    authorize! :edit, @component
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)
    authorize! :create, @component

    respond_to do |format|
      if @component.save
        format.html { redirect_to @component, notice: 'Component was successfully created.' }
        format.json { render :show, status: :created, location: @component }
      else
        format.html { render :new }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    authorize! :update, @component
    respond_to do |format|
      if @component.update(component_params)
        format.html { redirect_to @component, notice: 'Component was successfully updated.' }
        format.json { render :show, status: :ok, location: @component }
      else
        format.html { render :edit }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    authorize! :destroy, @component
    @component.destroy
    respond_to do |format|
      format.html { redirect_to components_url, notice: 'Component was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:max_quantity, :damaged, :missing, :consumable, :item_id, :component_category_id)
    end
end