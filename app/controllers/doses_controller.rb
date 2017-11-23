class DosesController < ApplicationController
  before_action :find_cocktail, only: [:new, :create, :destroy]
  before_action :find_dose, only: [:destroy]
  def new
    @dose = Dose.new
  end

  def create
    p dose_params
    @dose = Dose.new(description: dose_params[:description])
    @dose.ingredient = Ingredient.find(dose_params[:ingredient])
    @dose.cocktail = @cocktail
    p @dose
    if @dose.valid?
      @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render "new"
    end
  end

  def destroy
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def find_dose
    p params
    @dose = Dose.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
