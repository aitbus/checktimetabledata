
class Tasks::Maintask
  def self.execute
      #ここから処理始まります。

      #初期化
      self.init

      #時刻表のリンクチェック開始：http://www.ait.ac.jp/access/yakusa/
      self.updateLinks
  end

  def self.init
  	# urlHashData = UrlHashData.new()
  	# urlHashData.url='jjjblog.ppen.info'
  	# urlHashData.hash='ssssss'
  	# urlHashData.updateTime= Time.now.strftime("%Y-%m-%d %X:%M:%S")
  	# UrlHashDbManager.insert(urlHashData)


  	# urlHashData2 = UrlHashDbManager.selectWhereUrl('jjjblog.ppen.info')
  	# puts urlHashData2.hash

  end


  #時刻表のリンク集の更新
  def self.updateLinks
  	CheckHttpDataManager.check()

  end

end