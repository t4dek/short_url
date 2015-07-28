require 'rails_helper'

RSpec.describe LinksController do
  
  subject(:link) { Link.create(given_url: 'http://example.com/example') }  
  
  describe 'GET index' do
    it 'should render index' do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe 'POST create' do
    it 'should respond with ok status for ajax call' do
      xhr :post, :create, { link: {given_url: 'http://example.com/foobarbazbar'} }
      expect(response.status).to eq(200)
    end
    
    it 'should response with shortened link after ajax call with right params' do
      xhr :post, :create, { link: {given_url: 'http://example.com/foobarbazbaz'} }
      expect(response.body).to match /short_url/
    end
    
    it 'should respond with 422 status if link is not valid' do
      xhr :post, :create, { link: {given_url: '123'} }
      expect(response.status).to eq(422)
    end
    
    it 'should respond with errors json if link is not valid' do
      invalid_link = Link.create(given_url: '123')
      link_errors = invalid_link.errors.messages.to_json
      xhr :post, :create, { link: {given_url: invalid_link.given_url} }
      expect(response.body).to eq(link_errors)
    end
    
    it 'should not generate new uniq_key if given_url is already in database' do
      xhr :post, :create, { link: {given_url: link.given_url} }
      response_short_url = JSON.parse(response.body)['short_url']
      expect(response_short_url).to eq(short_url(link.uniq_key))
    end
  end
  
  describe 'GET show' do
    it 'should redirect user to given url when short url is called' do
      get :show, uniq_key: link.uniq_key
      expect(link).to redirect_to(link.given_url)
    end
  end
end
