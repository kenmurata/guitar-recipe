class PaypalsController < ApplicationController
  def index
    @paypals = Paypal.all.order(:id)
    #@paypal_column = @paypals.last.attributes.keys
    @paypal_column = ["日付","時間","タイムゾーン","名前","タイプ","ステータス","通貨","合計","手数料","正味","送信者メールアドレス","受信者メールアドレス","取引ID","配送先住所","住所ステータス","商品タイトル","商品ID","配送および手数料の額","保険金額","消費税","オプション1: 名前","オプション1: 金額","オプション2: 名前","オプション2: 金額","リファレンス トランザクションID","請求書番号","カスタム番号","数量","領収書ID","残高","住所1行目","住所2行目/地区/地域","市区町村","都道府県","郵便番号","国および地域","連絡先の電話番号","件名","備考","Country Code","Balance Impact"]
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
