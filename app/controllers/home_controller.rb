class HomeController < ApplicationController

  def index

  end

  def search
    @q = Content.all.accessible(current_user).ransack(title_or_description_cont: params[:q])
    @contents = @q.result
  end

end
