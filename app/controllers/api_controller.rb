class ApiController < ApplicationController

  respond_to :json

  def page_info
    if params[:link].present?
      begin
        page_info = Rails.cache.fetch(PageInfo.cache_key(params[:link]), expires_in: 12.hours) do
          response = RestClient.get(params[:link])
          WebScraper.new(response).page_info.to_json
        end

        respond_with(page_info)
      rescue => e
        respond_with({ error: e.to_s }, status: 422)
      end
    else
      respond_with({ message: 'link param must be specified' }, status: 400)
    end
  end

end
