class PaypalsController < ApplicationController
  def index
    @paypals = Paypal.all.order(:id)
    @paypal_column = @paypals.last.attributes.keys
    #puts @paypal_column
    @paypal_column.each do |pc|
      puts pc
    end
  end
  
  def import
    Paypal.import(params[:file])
    redirect_to root_path, notice: 'importしました'
  end
end
