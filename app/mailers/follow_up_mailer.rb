class FollowUpMailer < ApplicationMailer
  default from: "test@example.com"

  def sample_email(email)
    debugger
    @email = email
    mail(to: @email.email_address, subject: "Sample Email")
  end
end
