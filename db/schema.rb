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

ActiveRecord::Schema[8.0].define(version: 2025_05_26_163123) do
  create_table "loan_applications", force: :cascade do |t|
    t.string "applicant_name", null: false
    t.string "applicant_email", null: false
    t.string "applicant_phone"
    t.decimal "loan_amount", precision: 10, scale: 2, null: false
    t.string "loan_purpose"
    t.decimal "annual_income", precision: 10, scale: 2
    t.integer "credit_score"
    t.text "employment_details"
    t.text "additional_notes"
    t.string "status", default: "pending"
    t.string "agent_id"
    t.text "agent_notes"
    t.datetime "reviewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_loan_applications_on_agent_id"
    t.index ["created_at"], name: "index_loan_applications_on_created_at"
    t.index ["status"], name: "index_loan_applications_on_status"
  end
end
