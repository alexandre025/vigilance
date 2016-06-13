class HomeController < ApplicationController

  def index

  end

  def search
    @q = Content.accessible(current_user).ransack(params[:search])
    @contents = @q.result
  end

end
