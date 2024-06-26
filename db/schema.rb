# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_04_122534) do
  create_table "creatures", force: :cascade do |t|
    t.string "name"
    t.integer "health"
    t.integer "armor_class"
    t.integer "initiative"
    t.integer "encounter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "size"
    t.string "monster_type"
    t.string "alignment"
    t.integer "walking_speed"
    t.integer "fly_speed"
    t.integer "swim_speed"
    t.integer "position"
    t.index ["encounter_id"], name: "index_creatures_on_encounter_id"
  end

  create_table "encounters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "game_id"
    t.integer "current_turn", default: 1
    t.index ["game_id"], name: "index_encounters_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "premade_monsters", force: :cascade do |t|
    t.string "name"
    t.integer "health"
    t.integer "armor_class"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "size"
    t.string "monster_type"
    t.string "alignment"
    t.integer "walking_speed"
    t.integer "fly_speed"
    t.integer "swim_speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "index"
    t.index ["index"], name: "index_premade_monsters_on_index", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "creatures", "encounters"
  add_foreign_key "encounters", "games"
  add_foreign_key "games", "users"
end
