#models
require 'sequel'


@DB = Sequel.connect(adapter: 'sqlite', database: './things.db')
Sequel.extension :migration
Sequel::Migrator.run(@DB, './db/migrate/')

require_relative 'thing'