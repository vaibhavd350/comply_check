require 'rails_helper'

RSpec.describe KybApplication, type: :model do
  let(:kyb_application) { create(:kyb_application) }

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    context 'when status is rejected' do
      it 'requires rejection_reason' do
        kyb_application.status = :rejected
        expect(kyb_application.valid?).to be_falsey
        expect(kyb_application.errors[:rejection_reason]).to include(
          'must be provided when rejecting the KYB application.'
        )
      end
    end
  end

  describe 'callbacks' do
    describe '#trigger_mail' do
      it 'sends approval email when status changes to approved' do
        kyb_application.update(status: :approved)
        expect(kyb_application.resubmitted).to be_falsey
        expect(ActionMailer::Base.deliveries.last.subject).to eq('KYB Application Approved')
      end

      it 'sends rejection email when status changes to rejected' do
        kyb_application.update(status: :rejected, rejection_reason: 'Reason for rejection')
        expect(kyb_application.resubmitted).to be_falsey
        expect(ActionMailer::Base.deliveries.last.subject).to eq('KYB Application Rejected')
      end

      it 'does not send email when status is not changed' do
        kyb_application.update(updated_at: Time.now)
        mail_not_sent = ['KYB Application Approved', 'KYB Application Rejected'].exclude?(
          ActionMailer::Base.deliveries.last.subject
        )
        expect(mail_not_sent).to eq(true)
      end
    end
  end
end
