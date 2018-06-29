class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(email)
    # Do something later
    @email = email
    FollowUpMailer.sample_email(@email).deliver_later
  end
end
