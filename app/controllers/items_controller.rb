class ItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id]) # finding the parent
    @item = @list.items.build(item_params)
    if @item.save 
      respond_to do |f|
        f.html {redirect_to list_path(@list)}
        f.json {render :json => @item}
      end
    else
      render "lists/show"
    end
  end

  # PATCH - /lists/:list_id/items/:id
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    redirect_to list_path(@item.list)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |f|
      f.json {render :json => @item}
      f.html {redirect_to list_path(@item.list)}
    end
  end

  private
    def item_params
      params.require(:item).permit(:description, :status)
    end

end
