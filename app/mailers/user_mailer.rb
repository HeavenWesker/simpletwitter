class UserMailer < ActionMailer::Base
  default from: "password@aiwenhao.com"
  def password_reset(user)
    mail(to: user.email, subject: "Reset Password")
  end
end
