require 'rails_helper'

describe RestsController, type: :controller do

    describe 'GET #search' do
        before do
            get :search
        end
        it "render the :search template" do
            expect(response).to render_template :search
        end
    end

    describe 'GET #show' do
        before do
            @rest = create(:rest)
            # get :show, id: @rest.id
        end
        # it "render the :show (rest to @rest) template" do
        #     expect(response).to render_template :show
        # end
    end

end