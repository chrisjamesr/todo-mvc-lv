class ListsController < ApplicationController
  before_action :authentication_required
  
  def index
    @list = List.new
    @lists = List.all
    # render 'lists/index.html.erb'
  end

  def show
    @list = List.find(params[:id])
    if !can_current_user?(:view, @list)
      redirect_to root_path, :notice => "Can't find that..."
    end
    @item = Item.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_url(@list)
    else
      @lists = List.all
      render :index
    end
  end
  private

    def list_params # strong parameters
      params.require(:list).permit(:name)
    end
end
