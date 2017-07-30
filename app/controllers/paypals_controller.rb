class PaypalsController < ApplicationController
  def index
  end
  
  def import
    Paypal.import(params[:file])
    redirect_to root_path, notice: 'importしました'
  end
end
