# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class FollowUpMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    FollowUpMailer.sample_email(Email.first)
  end
end
