class ThemesController < ApplicationController
  def main
    @themes = Theme.order(created_at: :desc)
  end

  def create
    return unless params[:commit]

    begin
      theme = Theme.create!(title: params[:title], text: "#{params[:text]} ", user_id: session[:current_user_id])
      redirect_to action: 'show', id: theme.id
    rescue ActiveRecord::RecordInvalid => @error
      render :create, status: 422
    end
  end

  def show
    @@theme = @theme = Theme.find_by!(id: params[:id])
    @author = User.find_by(id: @theme.user_id)
    @@answers = @answers = Answer.where(theme_id: @theme.id).order(created_at: :desc)
  rescue ActiveRecord::RecordNotFound
    @show_error = (t :p_not_found)
  end

  def delete
    @@answers.each(&:destroy!) if @@answers != []
    @@theme.destroy!
    redirect_to root_url
  rescue ActiveRecord::RecordNotDestroyed
    @delete_error = (t :delete_error)
  end

  def create_ans
    return unless params[:commit]

    begin
      Answer.create!(text: "#{params[:text]} ", user_id: session[:current_user_id], theme_id: @@theme.id)
      redirect_to action: 'show', id: @@theme.id
    rescue ActiveRecord::RecordInvalid => @ans_error
      redirect_to action: 'show', id: @@theme.id
    end
  end

  def delete_ans
    begin
      answer = Answer.find_by(id: params[:id])
      answer.destroy!
      redirect_to action: 'show', id: @@theme.id
    rescue ActiveRecord::RecordNotDestroyed
      @delete_ans_error = (t :delete_error)
      redirect_to action: 'show', id: @@theme.id
    end
  end
end
