class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    @user = user
    FollowUpMailer.sample_email(@user).deliver_later
  end
end
