# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
LoanApplication.delete_all

# Create sample loan applications
loan_applications = [
  {
    applicant_name: "John Smith",
    applicant_email: "john.smith@email.com",
    applicant_phone: "(555) 123-4567",
    loan_amount: 25000.00,
    loan_purpose: "Home improvement",
    annual_income: 75000.00,
    credit_score: 720,
    employment_details: "Software Engineer at TechCorp Inc.\n5 years of experience\nSalary: $75,000/year",
    additional_notes: "Looking to renovate kitchen and bathroom. Have been with current employer for 5 years.",
    status: "pending"
  },
  {
    applicant_name: "Sarah Johnson",
    applicant_email: "sarah.johnson@email.com",
    applicant_phone: "(555) 987-6543",
    loan_amount: 15000.00,
    loan_purpose: "Debt consolidation",
    annual_income: 55000.00,
    credit_score: 680,
    employment_details: "Marketing Manager at ABC Company\n3 years of experience\nSalary: $55,000/year",
    additional_notes: "Want to consolidate credit card debt to reduce monthly payments.",
    status: "under_review",
    agent_id: "agent_001"
  },
  {
    applicant_name: "Michael Brown",
    applicant_email: "michael.brown@email.com",
    applicant_phone: "(555) 456-7890",
    loan_amount: 50000.00,
    loan_purpose: "Business expansion",
    annual_income: 120000.00,
    credit_score: 780,
    employment_details: "Business Owner - Brown's Auto Repair\n10 years of experience\nAnnual Revenue: $300,000",
    additional_notes: "Need capital to purchase new equipment and expand workshop space.",
    status: "approved",
    agent_id: "agent_002",
    agent_notes: "Excellent credit score and strong business history. Approved for full amount.",
    reviewed_at: 2.days.ago
  },
  {
    applicant_name: "Emily Davis",
    applicant_email: "emily.davis@email.com",
    applicant_phone: "(555) 321-0987",
    loan_amount: 30000.00,
    loan_purpose: "Medical expenses",
    annual_income: 45000.00,
    credit_score: 620,
    employment_details: "Nurse at City Hospital\n7 years of experience\nSalary: $45,000/year",
    additional_notes: "Need to cover unexpected medical bills not covered by insurance.",
    status: "denied",
    agent_id: "agent_003",
    agent_notes: "Credit score below minimum threshold. Debt-to-income ratio too high for requested amount.",
    reviewed_at: 1.day.ago
  },
  {
    applicant_name: "David Wilson",
    applicant_email: "david.wilson@email.com",
    applicant_phone: "(555) 654-3210",
    loan_amount: 35000.00,
    loan_purpose: "Car purchase",
    annual_income: 68000.00,
    credit_score: 710,
    employment_details: "Account Manager at Sales Solutions Inc.\n4 years of experience\nSalary: $68,000/year + commission",
    additional_notes: "Current car has major mechanical issues. Need reliable transportation for work.",
    status: "pending"
  },
  {
    applicant_name: "Lisa Rodriguez",
    applicant_email: "lisa.rodriguez@email.com",
    applicant_phone: "(555) 789-0123",
    loan_amount: 20000.00,
    loan_purpose: "Education",
    annual_income: 40000.00,
    credit_score: 650,
    employment_details: "Administrative Assistant at Local Government\n6 years of experience\nSalary: $40,000/year",
    additional_notes: "Pursuing master's degree in public administration. Need to cover tuition costs.",
    status: "pending"
  },
  {
    applicant_name: "Robert Taylor",
    applicant_email: "robert.taylor@email.com",
    applicant_phone: "(555) 234-5678",
    loan_amount: 45000.00,
    loan_purpose: "Home purchase down payment",
    annual_income: 85000.00,
    credit_score: 740,
    employment_details: "Senior Developer at InnovaTech\n8 years of experience\nSalary: $85,000/year",
    additional_notes: "First-time home buyer. Have found a property and need additional funds for down payment.",
    status: "under_review",
    agent_id: "agent_001"
  },
  {
    applicant_name: "Jennifer Martinez",
    applicant_email: "jennifer.martinez@email.com",
    applicant_phone: "(555) 567-8901",
    loan_amount: 18000.00,
    loan_purpose: "Wedding expenses",
    annual_income: 52000.00,
    credit_score: 690,
    employment_details: "Graphic Designer at Creative Agency\n3 years of experience\nSalary: $52,000/year",
    additional_notes: "Planning wedding for next summer. Need to cover venue and catering costs.",
    status: "approved",
    agent_id: "agent_002",
    agent_notes: "Good credit history and stable employment. Reasonable loan amount for income level.",
    reviewed_at: 3.days.ago
  }
]

puts "Creating loan applications..."

loan_applications.each_with_index do |app_data, index|
  # Add some random time variance to created_at
  created_time = rand(30.days).seconds.ago

  app = LoanApplication.create!(
    app_data.merge(
      created_at: created_time,
      updated_at: created_time
    )
  )

  puts "Created application ##{app.id} for #{app.applicant_name}"
end

puts "\nSeed data created successfully!"
puts "Total applications: #{LoanApplication.count}"
puts "Pending: #{LoanApplication.pending.count}"
puts "Under Review: #{LoanApplication.under_review.count}"
puts "Approved: #{LoanApplication.approved.count}"
puts "Denied: #{LoanApplication.denied.count}"
