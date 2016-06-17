class OrganizationMailer < ApplicationMailer
  def send_invit(assignment)
    @user = assignment.user
    @assignment = assignment
    @url = organization_join_url(@assignment.organization, auth_token: @user.auth_token, assignment_token: @assignment.assignment_token)
    mail(to: @user.email, subject: "Readis - You're invited in #{assignment.organization.name}")
  end
end
