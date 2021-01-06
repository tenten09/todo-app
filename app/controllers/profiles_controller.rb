class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def edit
    current_user.articles.build
    @profile = current_user.build_profile
  end
end