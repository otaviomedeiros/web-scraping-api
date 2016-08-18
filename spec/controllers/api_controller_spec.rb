require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe 'GET page_info' do

    context 'when there is no link param' do
      it "responds with bad request" do
        xhr :get, :page_info
        expect(response.status).to eq(400)
      end
    end

    context 'when there is link param' do
      context 'and it is an invalid url' do
        it "responds with Unprocessable entity" do
          xhr :get, :page_info, link: 'invalidurl'
          expect(response.status).to eq(422)
        end
      end

      context 'and it is an valid url' do
        it 'responds with 200 status code', :vcr do
          xhr :get, :page_info, link: 'http://www.skore.io'
          expect(response.status).to eq(200)
        end

        it 'responds with application/json content type', vcr: true do
          xhr :get, :page_info, link: 'http://www.skore.io'
          expect(response.content_type).to eq("application/json")
        end

        it 'responds with json in body', vcr: true do
          xhr :get, :page_info, link: 'http://www.skore.io'
          expect(response.body).to eq('{"title":"Skore","description":"","image":"https://s0.wp.com/i/blank.jpg"}')
        end
      end
    end
  end

end
