class LoanApplicationsController < ApplicationController
  before_action :set_loan_application, only: [ :show, :approve, :deny ]

  def index
    @loan_applications = LoanApplication.recent

    # Filter by status if provided
    if params[:status].present? && %w[pending approved denied under_review].include?(params[:status])
      @loan_applications = @loan_applications.where(status: params[:status])
    end

    # Search functionality
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @loan_applications = @loan_applications.where(
        "applicant_name ILIKE ? OR applicant_email ILIKE ?",
        search_term, search_term
      )
    end
  end

  def show
    # Mark as under review if it's pending and no agent assigned
    if @loan_application.pending? && @loan_application.agent_id.blank?
      @loan_application.update(status: "under_review", agent_id: current_agent_id)
    end
  end

  def approve
    @loan_application.approve!(current_agent_id, params[:agent_notes])
    redirect_to @loan_application, notice: "Application approved successfully."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @loan_application, alert: "Error approving application: #{e.message}"
  end

  def deny
    @loan_application.deny!(current_agent_id, params[:agent_notes])
    redirect_to @loan_application, notice: "Application denied."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @loan_application, alert: "Error denying application: #{e.message}"
  end

  private

  def set_loan_application
    @loan_application = LoanApplication.find(params[:id])
  end

  def current_agent_id
    # This should be replaced with actual authentication logic
    # For now, using a placeholder
    session[:agent_id] ||= "agent_#{SecureRandom.hex(4)}"
  end
end
