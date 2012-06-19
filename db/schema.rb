# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120615234734) do

  create_table "origenes_de_reporte", :force => true do |t|
    t.string   "codigo"
    t.string   "etiqueta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "origenes_de_reporte", ["codigo"], :name => "index_origenes_de_reporte_on_codigo", :unique => true

  create_table "urlws", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
