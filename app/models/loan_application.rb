class LoanApplication < ApplicationRecord
  validates :applicant_name, presence: true
  validates :applicant_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :loan_amount, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[pending approved denied under_review] }

  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }
  scope :denied, -> { where(status: "denied") }
  scope :under_review, -> { where(status: "under_review") }
  scope :recent, -> { order(created_at: :desc) }

  def approve!(agent_id, notes = nil)
    update!(
      status: "approved",
      agent_id: agent_id,
      agent_notes: notes,
      reviewed_at: Time.current
    )
  end

  def deny!(agent_id, notes = nil)
    update!(
      status: "denied",
      agent_id: agent_id,
      agent_notes: notes,
      reviewed_at: Time.current
    )
  end

  def pending?
    status == "pending"
  end

  def approved?
    status == "approved"
  end

  def denied?
    status == "denied"
  end

  def under_review?
    status == "under_review"
  end

  def status_badge_class
    case status
    when "approved"
      "bg-green-100 text-green-800"
    when "denied"
      "bg-red-100 text-red-800"
    when "under_review"
      "bg-yellow-100 text-yellow-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end

  def formatted_loan_amount
    "$#{loan_amount.to_f.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  end

  def formatted_annual_income
    return "N/A" unless annual_income
    "$#{annual_income.to_f.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  end
end
