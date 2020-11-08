class UsersController < ApplicationController

  def search
    users = []
    users = User.select('users.id, users.email').where('email LIKE ?', '%' + params[:term] + '%') if params[:term]

    render json: { users: users.as_json }
  end
end
