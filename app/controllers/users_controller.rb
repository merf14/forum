# frozen_string_literal: true

class UsersController < ApplicationController
  def registration
    return unless params[:commit]

    if params[:password] != params[:password_rep]
      @error = (t :pas_not_equal)
      render :registration, status: 422
    elsif (params[:name] == 'Deleted') || (params[:name] == 'Admin')
      @error = (t :wrong_name)
      render :registration, status: 422
    else
      begin
        User.create!(name: params[:name], email: params[:email], password: params[:password])
        authorization
      rescue ActiveRecord::RecordInvalid
        render :registration, status: 422
      end
    end
  end

  def authorization
    return unless params[:commit]

    begin
      user = User.find_by!(email: params[:email])
      if user.password != params[:password]
        @error = (t :wrong_pas)
        render :authorization, status: 422
      elsif user.name == 'Deleted'
        @error = (t :u_not_found)
        render :authorization, status: 422
      else
        session[:current_user_id] = user.id
        redirect_to root_url
      end
    rescue ActiveRecord::RecordNotFound
      @error = (t :u_not_found)
      render :authorization, status: 422
    end
  end

  def profile
    @@user = @user = User.find_by!(id: params[:id])
    if @user.id.zero?
      @show_error = (t :u_deleted)
    else
      @@themes = @themes = Theme.where(user_id: params[:id])
      @@answers_all = @answers_all = Answer.where(user_id: params[:id])
      @answer_theme_id = Set.new
      @answers_all.each do |answer|
        @answer_theme_id.add(answer.theme_id)
      end
    end
  rescue ActiveRecord::RecordNotFound
    @show_error = (t :u_not_found)
  end

  def delete
    logout
    if User.find_by(id: 0).nil?
      deleted_user = User.new(id: 0, name: 'Deleted', email: '', password: '')
      deleted_user.save(validate: false)
    end
    @@themes.update(user_id: 0)
    @@answers_all.update(user_id: 0)
    @@user.destroy
  rescue ActiveRecord::RecordNotDestroyed
    @delete_error = (t :delete_error)
  end

  def logout
    session.delete(:current_user_id)
    redirect_to root_url
  end

  def change
    @user = User.find_by(id: session[:current_user_id])
    return unless params[:commit]

    begin
      if @user.password != params[:password]
        @error = (t :wrong_pas)
        render :change, status: 422
      else
        @user.update!(name: params[:name], email: params[:email])
        redirect_to action: 'profile', id: @user.id
      end
    rescue ActiveRecord::RecordInvalid
      render :change, status: 422
    end
  end

  def set_en
    I18n.config.default_locale = :en
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def set_ru
    I18n.config.default_locale = :ru
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end
end
