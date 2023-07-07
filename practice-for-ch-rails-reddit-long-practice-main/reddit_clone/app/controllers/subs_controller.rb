class SubsController < ApplicationController
  before_action :set_sub, only: %i[ show edit update destroy ]

  # GET /subs
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  def show
  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  # GET /subs/1/edit
  def edit
  end

  # POST /subs
  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      redirect_to @sub, notice: "Sub was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subs/1
  def update
    if @sub.update(sub_params)
      redirect_to @sub, notice: "Sub was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /subs/1
  def destroy
    @sub.destroy
    redirect_to subs_url, notice: "Sub was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub
      @sub = Sub.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sub_params
      params.fetch(:sub, {})
    end
end
