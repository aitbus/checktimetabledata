# 
# 
# 
require 'open-uri'
require 'digest/sha1'
require 'pdf/reader'

require 'dotenv'


class CheckHttpDataManager
	@alertMsg = ''
	@isExitDifferData= false

	def initialize()

  	end

  	def self.check()
  		Dotenv.load! "config/setting/globalconfig.env"

  		self.checkMainUrl()#メイン部分のURLのチェック
  		self.checkTimeScheduleUrl()#予定表
  		self.checkTimeTableUrl()#時刻表

  		if @isExitDifferData == true
  			SlackManager.sendMessage("#{@alertMsg}","#{ENV['SLACK_NOTICE_CHANNEL']}")#slack通知
  		
  		else
  			#違いがなかった場合の処理
  			SlackManager.sendMessage("#{@alertMsg}","#{ENV['SLACK_NONOTICE_CHANNEL']}")#slack通知
  		end

  		#print "#{@alertMsg}"


  	end


  	def self.checkMainUrl()
  		urlHashData = UrlHashDbManager.selectWhereUrl('http://www.ait.ac.jp/access/yakusa/')
  		#urlHashData = UrlHashDbManager.selectWhereUrl('https://blog.ppen.info')
  		self.updateUrlData(urlHashData,false)

  	end

  	def self.checkTimeScheduleUrl()
  		urlHashData = UrlHashDbManager.selectWhereUrl('http://www.ait.ac.jp/assets/docs/access_yakusa01.pdf')
  		#urlHashData = UrlHashDbManager.selectWhereUrl('https://blog.ppen.info/wp/?p=298')
  		  	
  		self.updateUrlData(urlHashData,true)

  	end

  	def self.checkTimeTableUrl()
  		urlHashData = UrlHashDbManager.selectWhereUrl('http://www.ait.ac.jp/assets/docs/access_yakusa02.pdf')
  		#urlHashData = UrlHashDbManager.selectWhereUrl('https://blog.ppen.info/wp/?page_id=29')
  		  	
  		self.updateUrlData(urlHashData,true)

  	end



###############プライベート
	def self.updateUrlData(urlHashData = UrlHashData.new(),isPdf=false)
		if isPdf == true
			html = self.pdftext(open(urlHashData.url))
			hash = Digest::SHA1.hexdigest(html);
		else
			html = open(urlHashData.url).read.encode("utf-8",:invalid => :replace,:undef => :replace)
			hash = Digest::SHA1.hexdigest(html);
		end
		#print "url= #{urlHashData.url} hash=#{hash}"
		if hash != urlHashData.hash
			#データに違いがあった場合
			@isExitDifferData= true
			@alertMsg += "#{urlHashData.url}に違いがあるようです。\n"
			urlHashData.hash = hash
			UrlHashDbManager.insert(urlHashData)#データ更新

		else
			#データに差がなかった場合
			@alertMsg += "#{urlHashData.url}に違いはないようです。\n"
		end

	end

	def self.pdftext(io)
		reader = PDF::Reader.new(io)

		pdf_pages=""
		reader.pages.each do |page|
  			pdf_pages += page.text
		end

		return pdf_pages
	end


end