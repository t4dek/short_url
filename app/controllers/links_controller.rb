class LinksController < ApplicationController
  
  def index
    @link = Link.new
  end
  
  def create
    @link = Link.find_by(given_url: link_params[:given_url]) || Link.new(link_params)
    respond_to do |format|
      if @link.save
        format.js { render json: { short_url: short_url(@link.uniq_key) }.to_json }
      else
        format.js { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @link = Link.find_by(uniq_key: params[:uniq_key])
    redirect_to @link.given_url, status: 301
  end

  private
    def link_params
      params.require(:link).permit(:given_url)
    end
end
