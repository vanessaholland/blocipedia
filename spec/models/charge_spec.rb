require 'rails_helper'

RSpec.describe Charge, type: :model do
  let(:charge) { create(:charge) }
  it { is_expected.to belong_to(:user) }

  describe 'attributes' do
    it 'has a user, amount, and successful attributes' do
      expect(charge).to have_attributes(user: charge.user, amount: charge.amount, successful: charge.successful)
    end
  end
end
