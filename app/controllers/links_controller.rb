class LinksController < ApplicationController
  
  def index
    @links = Link.all
  end

  private
    def link_params
      params.require(:link).permit(:given_url, :uniq_key)
    end
end
