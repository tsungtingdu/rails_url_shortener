# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  render_views
  # let(:user) { create(:user, id: 1, email: 'test@example.com') }

  context '#index' do
    describe 'user not sign in' do
      it 'user can render index' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
        expect(response.body).to have_content('Sign in')
      end
    end
  end

  context '#show' do
    before do
      # url = create(:url)
      user = create(:user)
      url = Url.create(
        long_url: 'https://www.amazon.com/',
        short_url: 'akpitd',
        count: 0,
        user: user
      )
    end
    it 'user will be redirected to original site' do
      url = Url.all.last
      get :show, params: { id: url[:short_url] }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(url[:long_url])
      expect(response).not_to have_http_status(200)
    end
  end

  context '#create' do
    # success case
    it 'user can create short url with valid url successfully' do
      post :create, params: { url: { long_url: 'https://www.facebook.com/' } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    # fail case
    it 'user can not create short url with unvalid url' do
      post :create, params: { url: { long_url: 'test' } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(flash[:alert]).to eq 'please enter valid url'
    end
  end

  context 'When user signed in, ' do
    before do
      #  use Factorybot
      user = create(:user)
      sign_in(user)
    end

    it 'user can render index' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to have_content('Sign out')
    end

    it 'user can create short url with valid url successfully' do
      post :create, params: { url: { long_url: 'https://www.facebook.com/' } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to have_content(Url.all.last.short_url.to_s)
    end

    it 'user can delete short url successfully' do
      post :create, params: { url: { long_url: 'https://www.google.com/' } }
      @url = Url.all.last
      delete :destroy, params: { id: @url['id'] }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(urls_path)
      expect(response.body).to have_no_content(@url.short_url.to_s)
    end
  end
end
