require 'rails_helper'

RSpec.describe Rest, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe Rest do
    it 'is not be valid without name' do
      rest = Rest.new(name: '')
      expect(rest).not_to be_valid
    end
  end

end