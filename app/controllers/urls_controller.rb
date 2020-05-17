# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @url = Url.new
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
    render :index
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
