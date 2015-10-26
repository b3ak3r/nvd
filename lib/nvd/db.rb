module Nvd
  class Db
    require 'dbi'

    def initialize()
      begin
        @dbh = DBI.connect('DBI:Pg:b3ak3r-nvd:localhost', 'b3ak3r', ';;b3ak3r;;')

        row = @dbh.select_one("SELECT VERSION()")
        puts "Server version: " + row[0]
      rescue DBI::DatabaseError => e
        puts "An error occurred"
        puts "Error code: #{e.err}"
        puts "Error message: #{e.errstr}"
      ensure
        #@dbh.disconnect if dbh
      end
    end

    def exec_sql(cmd)
      begin
        @dbh.do(cmd)
      rescue DBI::DatabaseError => e
        puts "An error occurred - code: #{e.err} message: #{e.errstr}"
      end
    end

    def insert_vendor(vendor)
    end

    def insert_cve(cve)
      exec_sql("INSERT INTO cve VALUES (#{cve})")
    end
  end
end
