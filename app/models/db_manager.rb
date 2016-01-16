require 'sqlite3'


class DbManager
  def self.getDb
	 return SQLite3::Database.new('db/db.sqlite3')
  end
end