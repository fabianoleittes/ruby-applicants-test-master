class ModelsController < ApplicationController
  def index
    @models = Model.all
    SearchModels.fetch(params[:webmotors_make_id])
  end
end
