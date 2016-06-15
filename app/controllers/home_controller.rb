class HomeController < ApplicationController

  def index

  end

  def search
    @search_keywords = params[:q]
    @q = Content.all.accessible(current_user).ransack(title_or_description_cont: params[:q])
    @contents = @q.result
  end

  def saved

  end

end
