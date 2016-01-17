require 'sqlite3'


class UrlHashDbManager
  def self.insert(urlHashData=UrlHashData.new())
  	db = DbManager.getDb
	sql = "INSERT OR REPLACE INTO urlhash_t VALUES (?, ? ,?)"
	db.execute(sql, urlHashData.url, urlHashData.hash,urlHashData.updateTime)
	db.close
  end

  def self.selectWhereUrl(urlString)
  	urlHashData=UrlHashData.new()
  	urlHashData.url=urlString
  	db = DbManager.getDb
	sql = "SELECT * FROM urlhash_t WHERE url=? "
	db.execute(sql, urlString) do |url,hash,updatetime|
		urlHashData.url = urlString
		urlHashData.hash = hash
		urlHashData.updateTime = updatetime
	end

	db.close


	return urlHashData
  end

end