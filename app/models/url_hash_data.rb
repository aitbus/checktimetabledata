# URLとハッシュデータ
# 
# 


class UrlHashData
	url = ''
	hash = ''
	updateTime = ''

	def initialize()
    @url = 'nourl'
    @hash = 'nohash'
    @updateTime = Time.now.strftime("%Y-%m-%d %X:%M:%S")
  	end


	def url()
		@url
	end

	def url=(url)
		@url = url
	end

	def hash()
		@hash
	end

	def hash=(hash)
		@hash = hash
	end

	def updateTime()
		@updateTime
	end

	def updateTime=(updateTime)
		@updateTime = updateTime
	end



end