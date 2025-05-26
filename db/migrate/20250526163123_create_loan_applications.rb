class CreateLoanApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :loan_applications do |t|
      t.string :applicant_name, null: false
      t.string :applicant_email, null: false
      t.string :applicant_phone
      t.decimal :loan_amount, precision: 10, scale: 2, null: false
      t.string :loan_purpose
      t.decimal :annual_income, precision: 10, scale: 2
      t.integer :credit_score
      t.text :employment_details
      t.text :additional_notes
      t.string :status, default: 'pending'
      t.string :agent_id
      t.text :agent_notes
      t.datetime :reviewed_at
      t.timestamps
    end

    add_index :loan_applications, :status
    add_index :loan_applications, :agent_id
    add_index :loan_applications, :created_at
  end
end
