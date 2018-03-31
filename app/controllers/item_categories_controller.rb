class ItemCategoriesController < ApplicationController
  before_action :set_item_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]


  # GET /item_categories
  # GET /item_categories.json
  def index
    @item_categories = ItemCategory.all
  end


  # GET /item_categories/1
  # GET /item_categories/1.json
  def show
    authorize! :show, @item_category
    @item = @item_category.items.first
    @components = @item_category.items.first.components
    @kits_count = Kit.available_for_item_category(@item_category.id).count
    # TODO: item for reservation scope in reservation model?
    @reservations = Reservation.select{|r| r.return_date < Date.today &&
      Kit.find(r.kit_id).items.first.item_category.id == @item_category.id}
  end

  # GET /item_categories/new
  def new
    @item_category = ItemCategory.new
    authorize! :new, @item_category
  end

  # GET /item_categories/1/edit
  def edit
    authorize! :edit, @item_category
  end

  def rental_history
  end

  # POST /item_categories
  # POST /item_categories.json
  def create
    @item_category = ItemCategory.new(item_category_params)
    authorize! :create, @item_category

    respond_to do |format|
      if @item_category.save
        format.html { redirect_to @item_category, notice: 'Item category was successfully created.' }
        format.json { render :show, status: :created, location: @item_category }
      else
        format.html { render :new }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_categories/1
  # PATCH/PUT /item_categories/1.json
  def update
    authorize! :update, @item_category
    respond_to do |format|
      if @item_category.update(item_category_params)
        format.html { redirect_to @item_category, notice: 'Item category was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_category }
      else
        format.html { render :edit }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_categories/1
  # DELETE /item_categories/1.json
  def destroy
    authorize! :destroy, @item_category
    @item_category.destroy
    respond_to do |format|
      format.html { redirect_to item_categories_url, notice: 'Item category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_category
      @item_category = ItemCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_category_params
      params.require(:item_category).permit(:name, :description, :item_photo, :inventory_level, :amount_available)
    end
end
