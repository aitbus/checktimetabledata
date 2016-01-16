
class Tasks::Maintask
  def self.execute
      #ここから処理始まります。

      #初期化
      self.init

      #時刻表のリンクチェック開始：http://www.ait.ac.jp/access/yakusa/
      self.updateLinks
  end

  def self.init
  	DbManager.init
  end


  #時刻表のリンク集の更新
  def self.updateLinks

  end

end