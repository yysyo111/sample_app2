class ListsController < ApplicationController
  def new
    @list = List.new
  end
  
  def create
    @list = List.new(list_params)
    if @list.save
    redirect_to list_path(@list.id)
    else
      render :new
    end
  end
  
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end
  
  
  # マスアサインメント脆弱性を防ぐ「ストロングパラメータ」
  private
  
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end

# params:formから送られてくるデータはparamsの中に入る
# require:モデル名(ここでは:list)を指定し、データを絞り込み
# permit:保存を許可するカラムを指定
# list_params内では保存したいデータの絞り込み