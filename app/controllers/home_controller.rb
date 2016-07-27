class HomeController < ApplicationController
  def index
    @makes = Make.all

    SearchMakes.fetch
  end
end
