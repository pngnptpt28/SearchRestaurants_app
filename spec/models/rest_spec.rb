require 'rails_helper'

RSpec.describe Rest, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do 
    @rest = build(:rest)
  end

  describe Rest do
    # it 'is not be valid without name' do
    #   rest = Rest.create(:rest)
    #   expect(rest).not_to be_valid
    # end
  
    describe 'validation' do
      it 'is valid ?' do
        expect(@rest.valid?).to be_truthy
      end
    end

  end

end