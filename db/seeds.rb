# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Urlws.create!(:url => "http://200.41.238.203:8899/reports.asmx?WSDL")

@origenes = [
  ["Hidrovia_PZDE", "COZA"],
  ["Hidrovia_PZRP", "COBA"],
  ["Hidrovia_PZBP", "CORO"],
  ["Hidrovia_General", "Todos"]
]

@origenes.each { |ori|
  OrigenDeReporte.create!(:codigo => ori[0], :etiqueta => ori[1])
}
