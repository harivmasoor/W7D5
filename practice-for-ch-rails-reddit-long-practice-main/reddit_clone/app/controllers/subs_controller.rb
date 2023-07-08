class SubsController < ApplicationController
  before_action :require_logged_in, only:[:new, :create, :update, :edit]
  before_action :is_moderator?, only:[:edit,:update]

  # GET /subs
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  def show
    @sub = Sub.find_by(id: params[:id])
  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  # GET /subs/1/edit
  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  # POST /subs
  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url
    else
      flash.now[:errors] = @sub.errors.full_messages 
      render :new
    end
  end

  # PATCH/PUT /subs/1
  def update
    @sub = sub.find_by(id:params[:id])
    if @sub && @sub.update(sub_params)
      redirect_to user_url(@sub.moderator_id)
    else
      @sub = Sub.new(sub_params)
      flash.now[:errors] = ["sub not found"] 
    end 
    render :edit
  end

  # DELETE /subs/1
  def destroy
    @sub.destroy
    redirect_to subs_url
  end

  private

    # Only allow a list of trusted parameters through.
    def sub_params
      params.require(:sub).permit(:title)
    end

    def is_moderator?
      render json: "no access" if current_user.id != @sub.moderator_id # put if condition in separate line
    end


end
