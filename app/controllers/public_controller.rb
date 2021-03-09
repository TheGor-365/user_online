class PublicController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
    @online_users = User.where("last_seen_at > ?", 1.minutes.ago)
  end

end
