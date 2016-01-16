require 'sqlite3'


class DbManager
  def self.init
	SQLite3::Database.new('db/db.sqlite3') do |db|
		sql = "insert into urlhash_t values (?, ? ,?)"
		db.execute(sql, 'aa', 'hoge','ss')
		db.execute(sql, 'bb', 'fuga', 'ss')
	end
  end
end