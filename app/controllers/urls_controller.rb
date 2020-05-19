# frozen_string_literal: true

class UrlsController < ApplicationController
  include Greetable

  def index
    # for exercise - use concerns
    # say_hello
    # for exercise - use services
    # service = SlackNotifyService.new('已出借!')
    # service.perform

    @url = Url.new
    if current_user
      @urls = Url.where(user_id: current_user.id).order('created_at DESC')
    end
    flash[:alert] = nil
  end

  def show
    @url = Url.find_by short_url: params[:id]
    count = @url.count.nil? ? 1 : (@url.count + 1)
    @url.update(count: count)
    redirect_to @url.long_url.to_s
  end

  def create
    flash[:alert] = nil
    exist_url = Url.find_by long_url: url_params['long_url']

    if exist_url.nil? && valid_url?(url_params['long_url'])
      # create new

      @short_url = url_generator
      @result = Url.new(
        long_url: url_params['long_url'],
        short_url: @short_url,
        user: current_user,
        count: 0
      )
      @result.save
    elsif exist_url.nil? == false
      # use existed one
      @result = exist_url
    else
      flash[:alert] = 'please enter valid url'
    end
    # back to index page
    @url = Url.new
    if current_user
      @urls = Url.where(user_id: current_user.id).order('created_at DESC')
    end
    render :index
  end

  def destroy
    puts params[:id]
    @url = Url.where(
      id: params[:id],
      user_id: current_user.id
    ).first
    @url.destroy
    redirect_to urls_path
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end

  def url_generator
    is_unique = false
    until is_unique
      short_url = (0...6).map { rand(65..90).chr }.join.downcase
      exist_url = Url.find_by short_url: short_url
      is_unique = true if exist_url.nil?
    end
    short_url
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
