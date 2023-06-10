require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'relationships' do

  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :state }
  end
end