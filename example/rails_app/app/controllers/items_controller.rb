require "suture"
require "quality_updater"

class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create!(params[:item])
    redirect_to items_path
  end

  def update_all
    Item.all.each do |item|
      Suture.create :gilded_rose,
        :old => lambda { |item|
          item.update_quality!
          item
        },
        :new => lambda { |item|
          quality_updater = QualityUpdater.new
          quality_updater.update(item)
          item
        },
        :args => [item], # Uncomment to record calls to db/suture.sqlite3:
        :call_both => true
    end
    redirect_to items_path
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to items_path
  end
end
